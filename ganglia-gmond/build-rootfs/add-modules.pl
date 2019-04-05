#!/usr/bin/env perl
#
# Add additional modules to previously-generated rootfs.tar
#

use strict;
use warnings;


use File::Temp qw(tempdir);
use File::Path qw(make_path remove_tree);
use File::Copy qw(copy);
use Cwd qw(abs_path);


# target directories
my $LIBGANGLIA_DEST_DIR = '/usr/lib';
#my $LIBGANGLIA_DEST_DIR = '/usr/local/lib';
#my $LIBGANGLIA_DEST_DIR = '/usr/local/lib64';
my $MODULES_DEST_DIR    = '/usr/lib/ganglia';

# regex patterns
my $REGEX_SO_FILE = '\.so(\.\d+)*$';
my $REGEX_LIBEXPAT_FILE = 'libexpat.so(\.\d+)*$';

# overridable from argv
my $GANGLIA_BUILD_DIR = 'ganglia-3.6.1';
my $GMOND_BUILD_DIR   = "$GANGLIA_BUILD_DIR/gmond";


sub main;

main();



sub main {
    my $output_dir = create_temp_output_dir();
    copy_files($output_dir);
    append_to_tarball($output_dir);
}


sub create_temp_output_dir {
    my $output_dir = tempdir(CLEANUP => 1);
    #my $output_dir = tempdir();

    return $output_dir;
}


sub copy_files {
    my ($output_dir) = @_;


    # copy modules
    my $modules_dir = File::Spec->catdir($output_dir, $MODULES_DEST_DIR);
    make_path($modules_dir, { verbose => 1, mode => 0755 })
        || die "Error mkdir $modules_dir";

    my @so_filelist = list_module_files();
    print "@so_filelist\n";
    foreach my $f (@so_filelist) {
        copy $f, $modules_dir;
    }

    return;
######################################
    # copy libganglia-*.so
    my $libganglia_dir = File::Spec->catdir($output_dir, $LIBGANGLIA_DEST_DIR);
    make_path($libganglia_dir, { verbose => 1, mode => 0755 })
        ; #|| die "Error mkdir $libganglia_dir";

    my @libganglia_filelist = list_libganglia_files();
    print "@libganglia_filelist\n";
    foreach my $f (@libganglia_filelist) {
#########---->        copy $f, $libganglia_dir;
    }

}


sub list_module_files {
    my @result = ();

    my $module_dir_root = File::Spec->catdir($GMOND_BUILD_DIR, 'modules');
    my $search_output = `find $module_dir_root`;

    my @lines = split /\n/, $search_output;
    foreach my $line (@lines) {
        chomp $line;
        next unless $line =~ /$REGEX_SO_FILE/;
        push(@result, $line);
    }

    return @result;
}


sub list_libganglia_files {
    my @result = ();

    #
    # find libganglia-*.so
    #
    my $module_dir_root = File::Spec->catdir($GANGLIA_BUILD_DIR, 'lib', '.libs');
    my $search_output = `find $module_dir_root`;

    my @lines = split /\n/, $search_output;
    foreach my $line (@lines) {
        chomp $line;
        next unless $line =~ /$REGEX_SO_FILE/;
        push(@result, $line);
    }


    #
    # find libexpat.so
    #
    my $libexpat_dir_root = File::Spec->catdir('/', 'lib');
    my $search_output_1 = `find $libexpat_dir_root`;

    my @lines_1 = split /\n/, $search_output_1;
    foreach my $line (@lines_1) {
        chomp $line;
        next unless $line =~ /$REGEX_LIBEXPAT_FILE/;
#########------        push(@result, $line);
    }

    return @result;
}



sub append_to_tarball {
    my ($output_dir) = @_;

    # generate tarball...
    my $rootfs_tarball_path = abs_path( File::Spec->catfile(File::Spec->curdir(), 'rootfs.tar') );
    #print "--->>>", $rootfs_tarball_path, "\n";
    chdir $output_dir;
    my @cmd = ('tar', '--append', '--dereference', '-vf', $rootfs_tarball_path, '.');
    print "@cmd\n";
    #print `pwd`;
    system(@cmd);
    chdir '..';
}


sub process_cmdline {
    if (scalar @ARGV > 0) {
        $GANGLIA_BUILD_DIR = $ARGV[0];
        $GMOND_BUILD_DIR   = "$GMOND_BUILD_DIR/gmond";
    }
}
