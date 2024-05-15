<?php

namespace Tests\Feature;

use Tests\TestCase;
use Illuminate\Support\Facades\Artisan;

class ConsoleCommandTests extends TestCase
{
    /**
     * Test that the generate:key command generates a new app key.
     *
     * @return void
     */
    public function testGenerateKeyCommand()
    {
        // Run the generate:key command
        Artisan::call('generate:key');

        // Check if the command was successful (exit code 0)
        $this->assertEquals(0, Artisan::output());

        // Check if the app key has been generated
        $this->assertNotNull(config('app.key'));
    }
}
