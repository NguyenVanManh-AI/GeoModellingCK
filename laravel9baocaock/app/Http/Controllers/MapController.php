<?php

namespace App\Http\Controllers;

use App\Http\Requests\RequestAddMap;
use App\Http\Requests\RequestDeleteManyMap;
use App\Http\Requests\RequestUpdateMap;
use Illuminate\Http\Request;
use App\Traits\APIResponse;
use Illuminate\Support\Facades\Storage;
use Aws\S3\S3Client;
use Throwable;
use App\Models\Map;
use Illuminate\Support\Facades\DB;

class MapController extends Controller
{
    use APIResponse;
    public function addMap(Request $request) {
        try {

            $address = $request->address;
            $coordinates = $request->coordinates;
            $imageKeys = ['imagefull', 'px', 'nx', 'py', 'ny', 'pz', 'nz'];
            $uploadedUrls = [];
            foreach ($imageKeys as $key) {
                $file = $request->file($key);
                $name = time() . $file->getClientOriginalName();
                $filePath = 'linebot/' . $name;
                Storage::disk('s3')->put($filePath, file_get_contents($file));
                Storage::disk('s3')->setVisibility($filePath, 'public');
                $url = Storage::disk('s3')->url($filePath);
                $uploadedUrls[$key] = $url;
            }

            $data = [
                'address' => $address,
                'coordinates' => $coordinates,
                'imagefull' => $uploadedUrls['imagefull'],
                'px' => $uploadedUrls['px'],
                'nx' => $uploadedUrls['nx'],
                'py' => $uploadedUrls['py'],
                'ny' => $uploadedUrls['ny'],
                'pz' => $uploadedUrls['pz'],
                'nz' => $uploadedUrls['nz'],
            ];
            $map = Map::create($data);
            $map->coordinates = json_decode($map->coordinates);

            return $this->responseSuccessWithData($map, 'Add Map successfully !');
        } catch (Throwable $e) {
            return $this->responseError($e->getMessage());
        }
    }

    public function allMap(Request $request) {
        try {
            $orderBy = $request->typesort ?? 'new';
            switch ($orderBy) {
                case 'name':
                    $orderBy = 'address';
                    break;

                case 'new':
                    $orderBy = 'id';
                    break;

                default:
                    $orderBy = 'id';
                    break;
            }

            $orderDirection = $request->sortlatest ?? 'true';
            switch ($orderDirection) {
                case 'true':
                    $orderDirection = 'DESC';
                    break;

                default:
                    $orderDirection = 'ASC';
                    break;
            }

            $filter = (object) [
                'search' => $request->search ?? '',
                'orderBy' => $orderBy,
                'orderDirection' => $orderDirection,
            ];

            // repository
            $filter = (object) $filter;
            $data = Map::when(!empty($filter->search), function ($q) use ($filter) {
                    $q->where(function ($query) use ($filter) {
                        $query->where('address', 'LIKE', '%' . $filter->search . '%');
                    });
                })
                ->when(!empty($filter->orderBy), function ($query) use ($filter) {
                    $query->orderBy($filter->orderBy, $filter->orderDirection);
                });
            // repository

            if (!(empty($request->paginate))) $maps = $data->paginate($request->paginate);
            else $maps = $data->get();
            foreach($maps as $map) $map->coordinates = json_decode($map->coordinates);

            return $this->responseSuccessWithData($maps, 'Get maps information successfully!');
        } catch (Throwable $e) {
            return $this->responseError($e->getMessage());
        }
    }
    
    public function mapDetail(Request $request, $id_map)
    {
        DB::beginTransaction();
        try {
            $map = Map::find($id_map);
            if (empty($map)) {
                return $this->responseError('Not Found Map !', 404);
            }
            $map->coordinates = json_decode($map->coordinates);

            DB::commit();

            return $this->responseSuccessWithData($map, 'Get map detail successfully !');
        } catch (Throwable $e) {
            DB::rollback();

            return $this->responseError($e->getMessage());
        }
    }

    public function updateMap(RequestUpdateMap $request, $id_map)
    {
        DB::beginTransaction();
        try {
            $oldMap = Map::find($id_map);
            if (empty($oldMap)) {
                return $this->responseError('Not Found Map !', 404);
            }

            $address = $request->address;
            $coordinates = $request->coordinates;
            $data = [
                'address' => $address,
                'coordinates' => $coordinates,
            ];

            // if have update image 
            if($request->imagefull) {
                // upload file 
                $imageKeys = ['imagefull', 'px', 'nx', 'py', 'ny', 'pz', 'nz'];
                $uploadedUrls = [];
                foreach ($imageKeys as $key) {
                    $file = $request->file($key);
                    $name = time() . $file->getClientOriginalName();
                    $filePath = 'linebot/' . $name;
                    Storage::disk('s3')->put($filePath, file_get_contents($file));
                    Storage::disk('s3')->setVisibility($filePath, 'public');
                    $url = Storage::disk('s3')->url($filePath);
                    $uploadedUrls[$key] = $url;
                }
                $data = [
                    'address' => $address,
                    'coordinates' => $coordinates,
                    'imagefull' => $uploadedUrls['imagefull'],
                    'px' => $uploadedUrls['px'],
                    'nx' => $uploadedUrls['nx'],
                    'py' => $uploadedUrls['py'],
                    'ny' => $uploadedUrls['ny'],
                    'pz' => $uploadedUrls['pz'],
                    'nz' => $uploadedUrls['nz'],
                ];

                // delete file 
                foreach ($imageKeys as $key) {
                    $key_image = parse_url($oldMap->$key, PHP_URL_PATH);
                    // linebot/1710318263_bachkhoa.png
                    Storage::disk('s3')->delete($key_image);
                }
            }
  
            $oldMap->update($data);
            $oldMap->coordinates = json_decode($oldMap->coordinates);

            DB::commit();

            return $this->responseSuccessWithData($oldMap, 'Update map successfully !');
        } catch (Throwable $e) {
            DB::rollback();

            return $this->responseError($e->getMessage());
        }
    }

    public function deleteMap(Request $request, $id_map)
    {
        DB::beginTransaction();
        try {
            $map = Map::find($id_map);
            if (empty($map)) {
                return $this->responseError('Not Found Map !', 404);
            }

            // delete file 
            $imageKeys = ['imagefull', 'px', 'nx', 'py', 'ny', 'pz', 'nz'];
            foreach ($imageKeys as $key) {
                $key_image = parse_url($map->$key, PHP_URL_PATH);
                Storage::disk('s3')->delete($key_image);
            }
            $map->delete();

            DB::commit();

            return $this->responseSuccess('Delete map successfully !');
        } catch (Throwable $e) {
            DB::rollback();

            return $this->responseError($e->getMessage());
        }
    }

    public function deleteManyMap(RequestDeleteManyMap $request)
    {
        DB::beginTransaction();
        try {

            $ids_map = $request->ids_map;
            $maps = Map::whereIn("id",$ids_map)->get();
            foreach($maps as $map) {
                $imageKeys = ['imagefull', 'px', 'nx', 'py', 'ny', 'pz', 'nz'];
                foreach ($imageKeys as $key) {
                    $key_image = parse_url($map->$key, PHP_URL_PATH);
                    Storage::disk('s3')->delete($key_image);
                }
                $map->delete();
            }

            DB::commit();

            return $this->responseSuccess('Delete many map successfully !');
        } catch (Throwable $e) {
            DB::rollback();

            return $this->responseError($e->getMessage());
        }
    }
}
