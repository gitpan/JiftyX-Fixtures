package JiftyX::Fixtures::Script::Scaffold;
our $VERSION = '0.05';

# ABSTRACT: scaffold subcommands

use warnings;
use strict;

use Jifty;
use Jifty::Everything;

use IO::File;
use File::Spec;
use File::Basename;
use YAML qw(Dump LoadFile);

use base qw(
  JiftyX::Fixtures::Script::Base
  App::CLI::Command
);

sub options {
  my ($self) = @_;
  (
    $self->SUPER::options,
    'e|environment=s' => "environment",
  );
}

sub run {
  my ($self, $args) = @_;
  print "INFO - run " . ref($self) ."\n";
  Jifty->new;

  my @models = map { basename($_) } glob(
    File::Spec->catfile(
      $self->{config}->{app_root},
      "lib",
      $self->{config}->{framework}->{ApplicationClass},
      "Model",
      "*"
    )
  );

  for my $model (@models) {
    $model =~ s/\.pm//g;
    my %columns =  map { $_->name() => undef } Jifty->app_class("Model",$model)->columns;

    my $filename = File::Spec->catfile(
      $self->{config}->{app_root},
      $self->{config}->{fixtures}->{$self->{environment}}->{dir},
      "$model.yml"
    );

    print $filename,"\n";

    my $file = IO::File->new ;
    if (defined $file->open("> $filename") ) {
      print $file "-\n";
      for my $c (map {$_->name()} Jifty->app_class("Model",$model)->columns) {
        print $file "  $c:\n";
      }
      $file->close;
    }

  }

}

1;

__END__
=head1 NAME

JiftyX::Fixtures::Script::Scaffold - scaffold subcommands

=head1 VERSION

version 0.05

=head1 AUTHOR

  shelling <shelling@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by <shelling@cpan.org>.

This is free software, licensed under:

  The MIT (X11) License

