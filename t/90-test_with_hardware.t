##----------------------------------------------------------------------------
## :mode=perl:indentSize=2:tabSize=2:noTabs=true:
##----------------------------------------------------------------------------
##        File: 90-test_with_hardware.t
## Description: Test with actual hardware if the DEVICE_PROXR_TEST_PORT
##              environment variable is specified
##----------------------------------------------------------------------------
use Test::More;
use Device::ProXR;
my $port = $ENV{DEVICE_PROXR_TEST_PORT} // qq{};
unless ($port)
{
  plan skip_all => qq{Environment variable DEVICE_PROXR_TEST_PORT not specified};
}

diag(qq{Testing using port "$port"});
#my $board = Device::ProXR->new(port => $port);
my $board = new_ok(qq{Device::ProXR} => [port => $port]);
  
done_testing();