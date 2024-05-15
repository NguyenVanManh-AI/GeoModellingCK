<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

/**
 * @OA\Info(
 *     title="Tên ứng dụng",
 *     version="1.0",
 *     description="Mô tả của ứng dụng",
 *     @OA\Contact(
 *         email="admin@example.com",
 *         name="Admin"
 *     ),
 *     @OA\License(
 *         name="Apache 2.0",
 *         url="http://www.apache.org/licenses/LICENSE-2.0.html"
 *     )
 * )
 */

class TestSwaggerController extends Controller
{
    /**
     * Create a new post
     *
     * @OA\Post(
     *     path="/api/posts",
     *     summary="Create a new post",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 required={"title", "content"},
     *                 @OA\Property(property="title", type="string", example="New Post"),
     *                 @OA\Property(property="content", type="string", example="This is the content of the new post."),
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="Post created successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="id", type="integer"),
     *             @OA\Property(property="title", type="string"),
     *             @OA\Property(property="content", type="string"),
     *             @OA\Property(property="created_at", type="string"),
     *             @OA\Property(property="updated_at", type="string"),
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Validation error",
     *     )
     * )
     */
    public function createPost(Request $request)
    {
        $data = (object) [
            'title' => 'required|string|max:255',
            'content' => 'required|string',
        ];
        return response()->json($data, 201);
    }
}
