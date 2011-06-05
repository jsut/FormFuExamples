package Basic::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(
    namespace => '',
    default_view => 'TT',
);

=head1 NAME

Basic::Controller::Root - Root Controller for Basic

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) :FormConfig {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{'form'};

    if ($form->submitted_and_valid) {
        $c->stash->{'message'} = 'submitted and valid';
    }
    elsif ($form->submitted) {
        $c->stash->{'message'} = 'submitted';
    }
    else {
        $c->stash->{'message'} = 'loaded';
    }
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
