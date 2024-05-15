<?php

namespace Tests\Unit;

use App\Services\UserService;
// use PHPUnit\Framework\TestCase; // no use 
use Tests\TestCase; // should use 
use App\Models\User;
use App\Repositories\UserRepository; 
use Illuminate\Http\Request;
use Mockery;

class UserServiceUnitTest extends TestCase
{
    public function tearDown(): void
    {
        Mockery::close(); // Ensure that all mock objects are released after each test case
    }
    public function testIsAccountLocked()
    {
        $userRepository = new UserRepository();
        $userService = new UserService($userRepository);
                
        $user1 = new User(['is_delete' => 0, 'is_block' => 0]);
        $this->assertFalse($userService->isAccountLocked($user1));

        $user2 = new User(['is_delete' => 1, 'is_block' => 0]);
        $this->assertTrue($userService->isAccountLocked($user2));

        $user3 = new User(['is_delete' => 0, 'is_block' => 1]);
        $this->assertTrue($userService->isAccountLocked($user3));

        $user4 = new User(['is_delete' => 1, 'is_block' => 1]);
        $this->assertTrue($userService->isAccountLocked($user4));
    }

    public function testGetAllUsers()
    {
        $userRepositoryMock = Mockery::mock(UserRepository::class);
        $fakeData = [
            [
                "email" => "nguyenvanmanh2001it1@gmail.com",
                "line_user_id" => "U9b60d708a68e2b81a7ff7f9c57540779",
                "channel_id" => 1,
                "role" => "manager",
                "is_delete" => 0,
                "is_block" => 0
            ],
            [
                "email" => "nguyenvanmanh.it1@yopmail.com",
                "line_user_id" => "U667ca434abb5753fd28330c0441c7c78",
                "channel_id" => 2,
                "role" => "manager",
                "is_delete" => 1,
                "is_block" => 0
            ]
        ];
        $userRepositoryMock->shouldReceive('getMembers')->andReturn($fakeData);
        $userService = new UserService($userRepositoryMock);
        $request = new Request();
        $result = $userService->getAllMembers($request)->getContent();
        $decodedResult = json_decode($result, true);
        $expectedResults = [
            [
                "email" => "nguyenvanmanh2001it1@gmail.com",
                "line_user_id" => "U9b60d708a68e2b81a7ff7f9c57540779",
                "channel_id"=> 1,
                "role" => "manager",
                "is_delete" => 0,
                "is_block" => 0
            ]
        ];
        $this->assertEquals($expectedResults, $decodedResult['data']);
    }
}
