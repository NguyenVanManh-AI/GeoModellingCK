<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;
use App\Models\User;

class AuthenticatedFeatureTest extends TestCase
{
    public function testAuthenticatedUserCanAccessProtectedRoute()
    {
        $user = new User([]);
        
        // Authenticate as the user
        $this->actingAs($user, 'user_api');
    
        // Assert that the user is authenticated
        $this->assertAuthenticatedAs($user, 'user_api');
    
        // Make a request to the protected route
        $response = $this->get('api/user/profile');
    
        // Assert that the response status is 200 (OK)
        $response->assertStatus(200);
    }
}
