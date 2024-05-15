<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class UserLoginFeatureTest extends TestCase
{
    public function testUserLoginEmptyEmail()
    {
        $data = [
            'email' => '',
            'password' => '123456',
        ];
        $response = $this->post('api/user/login', $data);
        $response->assertStatus(422);
        $response->assertJson([
            "errors" => [
                "email" => [
                    "The email field is required."
                ]
            ],
            "messages" => [
                "The email field is required."
            ],
            "status" => 422
        ]);
    }

    public function testUserLoginEmptyPassword()
    {
        $data = [
            'email' => 'nguyenvanmanh2001it1@gmail.com',
            'password' => '',
        ];
        $response = $this->post('api/user/login', $data);
        $response->assertStatus(422);
        $response->assertJson([
            "errors" => [
                "password" => [
                    "The password field is required."
                ]
            ],
            "messages" => [
                "The password field is required."
            ],
            "status" => 422
        ]);
    }

    public function testUserLoginValidEmail()
    {
        $data = [
            'email' => 'nguyenvanmanh2001it1',
            'password' => '123456',
        ];
        $response = $this->post('api/user/login', $data);
        $response->assertStatus(422);
        $response->assertJson([
            "errors" => [
                "email" => [
                    "The email must be a valid email address."
                ]
            ],
            "messages" => [
                "The email must be a valid email address."
            ],
            "status" => 422
        ]);
    }

    public function testUserLoginEmailNotExist()
    {
        $data = [
            'email' => 'abc@gmail.com',
            'password' => '123456',
        ];
        $response = $this->post('api/user/login', $data);
        $response->assertStatus(400);
        $response->assertJson([
            "messages" => [
                "Email does not exist !"
            ],
            "status" => 400
        ]);
    }

    public function testUserLoginEmailOrPasswordIncorrect()
    {
        $data = [
            'email' => 'nguyenvanmanh2001it1@gmail.com',
            'password' => '1234567',
        ];
        $response = $this->post('api/user/login', $data);
        $response->assertStatus(400);
        $response->assertJson([
            "messages" => [
                "Email or password is incorrect!"
            ],
            "status" => 400
        ]);
    }

    public function testUserLoginAccountLocked()
    {
        $data = [
            'email' => 'nguyenvanmanh.it1@yopmail.com',
            'password' => '123456',
        ];
        $response = $this->post('api/user/login', $data);
        $response->assertStatus(400);
        $response->assertJson([
            "messages" => [
                "Your account has been locked !"
            ],
            "status" => 400
        ]);
    }

    public function testUserLoginSuccessful()
    {
        $data = [
            'email' => 'nguyenvanmanh2001it1@gmail.com',
            'password' => '123456',
        ];
        $response = $this->post('api/user/login', $data);
        $response->assertStatus(200);
        $response->assertJson([
            "data" => [
                "id" => 1,
                "email" => "nguyenvanmanh2001it1@gmail.com",
                "line_user_id" => "U9b60d708a68e2b81a7ff7f9c57540779",
                "channel_id" => 1,
                "role" => "manager",
                "is_delete" => 0,
                "is_block" => 0,
                "name" => "Nguyễn Văn Mạnh",
                "avatar" => null,
                "phone" => "0971404372",
                "address" => "Phú Đa - Phú Vang - TT Huế",
                "gender" => 0,
                "date_of_birth" => "2001-08-29",
                "token_type" => "bearer",
                "expires_in" => 1209600
            ],
            "messages" => [
                "Logged in successfully !"
            ],
            "status" => 200
        ]);
    }
    
}