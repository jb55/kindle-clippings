#!/usr/bin/env perl

$, = ' ';    # set output field separator
$\ = "\n";    # set output record separator

print "---";

while (<>) {
  chomp;  # strip record separator

  if (/^==========/ || $. == 1) {
    if ($. == 1) {
        $title = $_;
        # remove bom
        $title =~ s/[^[:print:]]+//;
    }
    else {
        $_ = &Getline0();
        $title = $_;
    }
    $_ = &Getline0();

    my $type, $loc_start, $loc_end, $page, $added;

    if ($_ =~ /Your ([^[:space:]]+)/) {
        $type = lc($1);
    }

    if ($_ =~ /Location ([[:digit:]]+)(?:-([[:digit:]]+))?/) {
        $loc_start = $1;
        $loc_end   = $2;
    }

    if ($_ =~ /Page ([[:digit:]]+)/) {
        $page = $1;
    }

    if ($_ =~ /Added on (.*)$/) {
        $added = $1;
    }

    Getline0();
    $clipping = &Getline0();
    $clipping =~ s/"/\\"/g;
    $title =~ s/"/\\"/g;
    $title =~ s/[[:space:]]+$//;

    if ($type) {
        print "-";
        print "  title: \"$title\"";
        print "  type: $type";
        $page and print "  page: $page";
        $loc_start and print "  location_start: $loc_start";
        $loc_end and print "  location_end: $loc_end";
        $added and print "  added: \"$added\"";
        $clipping and print "  clipping: \"$clipping\"";
    }
  }
}

sub Getline0 {
    if ($getline_ok = (($_ = <>) ne '')) {
        chomp;  # strip record separator
        $_;;
    }
    ;;
}
