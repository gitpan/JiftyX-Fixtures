package JiftyX::Fixtures::Script::Base;
our $VERSION = '0.03';

use warnings;
use strict;

use base qw(
  App::CLI::Command
);

sub options {
  return (
    'h|help|?'  => 'help',
    'man'     => 'man',
  );
}

sub run {
  my ($self) = @_;
  print "run() does not defined in " . ref($self) . "\n";
}


1;

__END__
=head1 NAME

JiftyX::Fixtures::Script::Base

=head1 VERSION

version 0.03

=head1 AUTHOR

  shelling <shelling@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by <shelling@cpan.org>.

This is free software, licensed under:

  The MIT (X11) License

