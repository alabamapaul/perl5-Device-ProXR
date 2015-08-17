##----------------------------------------------------------------------------
## :mode=perl:indentSize=2:tabSize=2:noTabs=true:
##----------------------------------------------------------------------------
##        File: 90-test_with_hardware.t
## Description: Test with actual hardware if the DEVICE_PROXR_TEST_PORT
##              environment variable is specified
##----------------------------------------------------------------------------
use Test::More;
use Device::ProXR::RelayControl;
my $port = $ENV{DEVICE_PROXR_TEST_PORT} // qq{};
unless ($port)
{
  plan skip_all => qq{Environment variable DEVICE_PROXR_TEST_PORT not specified};
}

diag(qq{Testing using port "$port"});
#my $board = Device::ProXR->new(port => $port);
my $board = new_ok(qq{Device::ProXR::RelayControl} => [port => $port]);

my $resp;
diag(qq{Turning ON bank 1 relay 1});
$resp = $board->relay_on(1, 0);
cmp_ok(length($resp), '==', 1, qq{relay_on() response length});
cmp_ok(ord(substr($resp, 0, 1)), '==', 0x55, qq{relay_on() response 0x55});

sleep(2);

diag(qq{Turning OFF bank 1 relay 1});
$resp = $board->relay_off(1, 0);
cmp_ok(length($resp), '==', 1, qq{relay_off() response length});
cmp_ok(ord(substr($resp, 0, 1)), '==', 0x55, qq{relay_off() response 0x55});

done_testing();