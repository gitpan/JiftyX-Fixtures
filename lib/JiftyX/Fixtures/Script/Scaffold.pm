package JiftyX::Fixtures::Script::Scaffold;
our $VERSION = '0.04';

# ABSTRACT: scaffold subcommands

use warnings;
use strict;

use base qw(
  JiftyX::Fixtures::Script::Base
  App::CLI::Command
);

sub options {
  my ($self) = @_;
  (
    $self->SUPER::options,
  );
}

sub run {
  my ($self, $args) = @_;
  print "INFO - run " . ref($self) ."\n";
}

1;

__END__
=head1 NAME

JiftyX::Fixtures::Script::Scaffold - scaffold subcommands

=head1 VERSION

version 0.04

=head1 AUTHOR

  shelling <shelling@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by <shelling@cpan.org>.

This is free software, licensed under:

  The MIT (X11) License

