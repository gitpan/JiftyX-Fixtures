package JiftyX::Fixtures::Script::Scaffold;
our $VERSION = '0.06';

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
  App::CLI::Command
);

my $super = 'JiftyX::Fixtures::Script';

our $help_msg = qq{
Usage:

  jiftyx-fixtures scaffold [options]

Options:

  -e, --environment:        specify environment, default is development
  -h, --help:               show help
  --man                     man page

};

sub options {
  my ($self) = @_;
  (
    $super->options,
    'e|environment=s' => "environment",
  );
}

sub before_run {
  my ($self) = @_;

  $super->before_run($self);

  $self->{environment} ||= "development";

  return;
}

sub run {
  my ($self, $args) = @_;
  $self->before_run();

  Jifty->new;

  for my $model ($self->model_list) {
    # my %columns =  map { $_->name() => undef } Jifty->app_class("Model",$model)->columns;

    my $filename = $self->fixtures_filename($model, "yml");
    my $file = IO::File->new ;
    if (defined $file->open("> $filename") ) {
      print $file "-\n";
      for my $c (Jifty->app_class("Model",$model)->columns) {
        print $file "  " . $c->name . ":\n" if $c->{writable};
      }
      $file->close;
    }

  }

}

sub model_list {
  my ($self) = @_;
  my @result =  map { basename($_) } glob(
    File::Spec->catfile(
      $self->{config}->{app_root},
      "lib",
      $self->{config}->{framework}->{ApplicationClass},
      "Model",
      "*"
    )
  );
  for (@result) {
    $_ =~ s/\.pm//g;
  }
  @result;
}

sub fixtures_filename {
  my ($self, $model, $format) = @_;
  return File::Spec->catfile(
      $self->{config}->{app_root},
      $self->{config}->{fixtures}->{$self->{environment}}->{dir},
      "$model.$format"
  );
}


1;

__END__
=head1 NAME

JiftyX::Fixtures::Script::Scaffold - scaffold subcommands

=head1 VERSION

version 0.06

=head1 AUTHOR

  shelling <shelling@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by <shelling@cpan.org>.

This is free software, licensed under:

  The MIT (X11) License

