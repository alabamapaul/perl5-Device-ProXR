package Device::ProXR;
##----------------------------------------------------------------------------
## :mode=perl:indentSize=2:tabSize=2:noTabs=true:
##****************************************************************************
## NOTES:
##  * Before comitting this file to the repository, ensure Perl Critic can be
##    invoked at the HARSH [3] level with no errors
##****************************************************************************

=head1 NAME

Device::ProXR - A  Moo based object oriented interface for creating 
controlling devices using the National Control Devices ProXR command set

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

  use Device::ProXR;

  my $board = Device::ProXR->new;


=cut

##****************************************************************************
##****************************************************************************
use Moo;
## Moo enables strictures
## no critic (TestingAndDebugging::RequireUseStrict)
## no critic (TestingAndDebugging::RequireUseWarnings)
use Readonly;
use Carp qw(confess cluck);

## Version string
our $VERSION = qq{0.01};


1;
