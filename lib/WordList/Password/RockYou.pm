package WordList::Password::RockYou;

# AUTHORITY
# DATE
# DIST
# VERSION

use parent qw(WordList);

our $SORT = 'popularity';
our $DYNAMIC = 1;

our %STATS = (
    'num_words' => 14344391,
);

sub new {
    my $class = shift;
    my $self = $class->SUPER::new(@_);
    $self->{fh_seekable} = 0;
    $self;
}

sub first_word {
    require File::ShareDir;

    my $self = shift;

    my $dir;
    eval { $dir = File::ShareDir::dist_dir('WordList-Password-RockYou') };
    if ($@) {
        $dir = "share";
    }
    (-d $dir) or die "Can't find share dir";
    my $path = "$dir/wordlist.txt.gz";
    (-f $path) or die "Can't find wordlist file '$path'";
    open my $fh, "<:gzip", $path
        or die "Can't open wordlist file '$path': $!";
    $self->{fh} = $fh;
    $self->{fh_orig_pos} = 0;
}

1;
# ABSTRACT: RockYou password wordlist (~14.3mil passwords)

=head1 DESCRIPTION

This class' C<word_exists()> uses linear search which is unusably slow. For
quick checking against wordlist, see L<WordList::Password::RockYou::BloomOnly>
which uses bloom filter.


=head1 METHODS

=cut
