<?php

namespace Tests\Feature\Content;

use Database\Seeders\AdminsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use App\Models\User;
use Tests\TestCase;

class CreateContentFeatureTest extends TestCase
{
    // use RefreshDatabase; // clear all data in database 

    public $token = '';

    protected function setUp(): void
    {

        parent::setUp();

        $data = [
            'email' => 'nguyenvanmanh2001it1@gmail.com',
            'password' => '123456',
        ];
        $response = $this->post('api/user/login', $data);
        $this->token = $response->json('data.access_token');
    }

    private function getAuthorizationHeaders()
    {
        return [
            'Authorization' => 'Bearer ' . $this->token,
        ];
    }
    
    public function testCreateContentTextSuccessful()
    {
        // Input data 
        $data = [
            "content_type" => "text",
            "content_data" => [
                "type" => "text",
                "text" => "Hello, world"
            ]
        ];

        // endpoint 
        $response = $this->post('api/content/add', $data, $this->getAuthorizationHeaders());

        // Response Assertions
        $response->assertStatus(200);
        $response->assertJson([
            "messages" => [
                "Add new content successfully !"
            ],
            "status" => 200
        ]);
    }

    public function testCreateContentImageSuccessful()
    {
        // Storage::fake('thumbnails');
        $thumbnail = UploadedFile::fake()->image('thumbnail.jpg');
        $data = [
            "content_type" => "image",
            "image_content" => $thumbnail
        ];
        $response = $this->post('api/content/add', $data, $this->getAuthorizationHeaders());
        $response->assertStatus(200);
        $response->assertJson([
            "messages" => [
                "Add new content successfully !"
            ],
            "status" => 200
        ]);
    }
    public function testFileDownload()
    {
        $response = $this->get('api/s3/download?file_url=https://linebotpro.s3.us-east-2.amazonaws.com/linebot/17138820951680405782.jpg');
    
        $response->assertStatus(200)
                 ->assertDownload();
    }

    // public function test_orders_can_be_created(): void
    // {
    //     $this->seed(AdminsSeeder::class);
    // }
}
