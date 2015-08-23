##----------------------------------------------------------------------------
## :mode=perl:indentSize=2:tabSize=2:noTabs=true:
##----------------------------------------------------------------------------
##        File: release-kwalitee.t
## Description: Run the kwalitee tests
##----------------------------------------------------------------------------
## NOTE:
##    Originally was allowing Dist::Zilla automatically generate this but
##    found it would not work on my Windows 7 64-bit system, but worked
##    fine in linux.
##----------------------------------------------------------------------------
use strict;
use warnings;
use Test::More 0.88;

BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
  if ($^O eq 'MSWin32')
  {
    require Test::More;
    Test::More::plan(skip_all => 'Kwalitee tests have problems under Windoze');
  }
}

## no critic (ProhibitStringyEval, RequireCheckingReturnValueOfEval)
eval q(Test::Kwalitee 1.21 'kwalitee_ok');
plan skip_all => q(Test::Kwalitee required for kwalitee testing) if $@;


kwalitee_ok();

done_testing;
