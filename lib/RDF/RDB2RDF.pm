package RDF::RDB2RDF;

use 5.008;
use common::sense;

use RDF::RDB2RDF::Simple;
use RDF::RDB2RDF::R2RML;
use RDF::RDB2RDF::DirectMapping;
use RDF::RDB2RDF::DirectMapping::Store;

our $VERSION = '0.003';

sub new
{
	my ($class, $type, @args) = @_;
	
	my $map = {
		simple        => 'Simple',
		r2rml         => 'R2RML',
		direct        => 'DirectMapping',
		directmapping => 'DirectMapping',
		};
	
	$type = $map->{lc $type} if exists $map->{lc $type};
	$class .= '::'.$type;
	
	$class->new(@args);
}

sub process
{
	die "Not implemented.\n";
}

sub process_turtle
{
	my ($self, $dbh, %options) = @_;
	
	my $model = $self->process($dbh);
	return RDF::Trine::Serializer
		->new('Turtle', %options)
		->serialize_model_to_string($model);
}

1;

=head1 NAME

RDF::RDB2RDF - map relational database to RDF declaratively

=head1 SYNOPSIS

 print RDF::RDB2RDF->new(R2RML => $r2rml)->process_turtle($dbh);

=head1 DESCRIPTION

It's quite common to want to map legacy relational (SQL) data to RDF. This is
usually quite simple to do by looping through database tables and spitting out
triples. Nothing wrong with that; I've done that in the past, and that's what
RDF::RDB2RDF does under the hood.

But it's nice to be able to write your mapping declaratively. This distribution
provides three modules to enable that:

=over

=item * L<RDF::RDB2RDF::Simple> - map relational database to RDF easily

=item * L<RDF::RDB2RDF::R2RML> - map relational database to RDF using R2RML

=item * L<RDF::RDB2RDF::DirectMapping> - map relational database to RDF directly

=back

C<RDF::RDB2RDF> itself provides a wrapper for constructing mapper objects,
and acts as a base class for the three implementations.

There is also a module L<RDF::RDB2RDF::DirectMapping::Store> which uses 
the same mapping as L<RDF::RDB2RDF::DirectMapping> but provides the same 
interface as L<RDF::Trine::Store>.

=head1 SEE ALSO

L<RDF::Trine>.

L<RDF::RDB2RDF::Simple>,
L<RDF::RDB2RDF::R2RML>,
L<RDF::RDB2RDF::DirectMapping>.

L<RDF::RDB2RDF::DirectMapping::Store>.

L<http://perlrdf.org/>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT

Copyright 2011 Toby Inkster

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
