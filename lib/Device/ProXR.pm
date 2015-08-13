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

  my $board = Device::ProXR->new(port => 'COM1');


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


BEGIN
{
  if ($^O eq 'MSWin32')
  {
    require Win32::SerialPort;
    Win32::SerialPort->import;
  }
  else
  {
    require Device::SerialPort;
    Device::SerialPort->import;
  }
}
##****************************************************************************
## Object attribute
##****************************************************************************

=head1 ATTRIBUTES

=cut

##****************************************************************************
##****************************************************************************

=over 2

=item B<port>

  Port used to communicate with the device

=back

=cut

##----------------------------------------------------------------------------
has port => (
  is      => qq{rw},
  default => qq{},
);

##****************************************************************************
##****************************************************************************

=over 2

=item B<baud>

  Baud rate for port used to communicate with the device.
  NOTE: This only applies to serial port communications
  DEFAULT: 115200

=back

=cut

##----------------------------------------------------------------------------
has baud => (
  is      => qq{rw},
  default => qq{115200},
);

##****************************************************************************
##****************************************************************************

=over 2

=item B<API_mode>

  Enable the API mode of communications. This mode adds byte counts and
  checksums to all commands and responses.
  DEFAULT: 1

=back

=cut

##----------------------------------------------------------------------------
has API_mode => (
  is      => qq{rw},
  default => qq{1},
);

##****************************************************************************
## "Private" atributes
##***************************************************************************

## Holds the port object 
has _port_obj  => (
  is      => qq{rw},
  default => undef,
);

## Error message
has _error_message => (
  is      => qq{rw},
  default => qq{},
);


##****************************************************************************
## Object Methods
##****************************************************************************

=head1 METHODS

=cut

##----------------------------------------------------------------------------
##     @fn _get_port_object()
##  @brief Returns the port object, opening it if needed. Returns UNDEF
##         on error and sets last_error
##  @param 
## @return Port object, or UNDEF on error
##   @note 
##----------------------------------------------------------------------------
sub _get_port_object ## no critic (ProhibitUnusedPrivateSubroutines)
{
  my $self = shift;
  
  ## Returh the object if it already exists
  return($self->_port_obj) if ($self->_port_obj);
  
  ## See if a port was specified
  unless ($self->port)
  {
    $self->_error_message(qq{Missing port attribute!});
    return;
  }

  ## Create the object
  my $obj;
  
  ## See if we running Windows
  if ($^O eq q{MSWin32})
  {
    ## Running Windows, use Win32::SerialPort
    $obj = Win32::SerialPort->new($self->port, 1);
  }
  else
  {
    ## Not running Windows, use Device::SerialPort
    $obj = Device::SerialPort->new($self->port, 1);
  }
  
  ## See if opened the port
  unless ($obj)
  {
    ## There was an error opening the port
    $self->_error_message(qq{Could not open port "} . $self->port . qq{"});
    return;
  }
  
  ## Configure the port
  $obj->baudrate($self->baud);
  $obj->parity(qq{none});
  $obj->databits(8);
  $obj->stopbits(1);
  $obj->handshake(qq{none});
  $obj->purge_all;
  
  ## Set the port object
  $self->_port_obj($obj);
  
  ## Return the port object
  return($self->_port_obj);
}



##****************************************************************************
##****************************************************************************

=head2 last_error()

=over 2

=item B<Description>

Returns the last error message

=item B<Parameters>

NONE

=item B<Return>

String containing the last error, or an empty string if no error has been
encountered

=back

=cut

##----------------------------------------------------------------------------
sub last_error
{
  my $self = shift;
  
  return($self->_error_message);
}

1;
