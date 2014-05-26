#!usr/bin/perl
#use strict;
use warnings;
use Path::Class;
#use autodie;
use Data::Dumper;
#use Data::Printer;
{
  package Data::Dumper;
  no strict 'vars';
  $Terse = $Indent = $Useqq = $Deparse = $Sortkeys = 1;
  $Quotekeys = 0;
}
use lib "C:/camelbox/site/lib";
use lib "C:/camelbox/lib";
use Gtk2 '-init';
use constant TRUE =>1;
use constant FALSE =>0;
#use Cellular::Automata::Wolfram;
sub rule110{
  my $png_file = shift;
  my $caw = 
	new Cellular::Automata::Wolfram(
	rule=>$rule,radius=>$radius,width=>$width,num_of_gens=>$gens,random=>$random,
	colors=>[$textcolor,$backgroundcolor],draw_file=>$filesavelocation->get_file_location);
	my $ar_gens = $caw->gens();
	CORE::dump($ar_gens);
	$caw->draw($png_file);
	}

my $window1=Gtk2::Window->new;
	$window1->signal_connect(destroy =>sub{Gtk2::Main::Quit});
	$window1->set_title("Rule 110.");
	$window1->set_border_width(4);
	$window1->set_default_size(500, 250);
my $VBox1=Gtk2::VBox->new;
our $rule=Gtk2::Entry->new;
	$rule->set_text("The number which defines the automata's rule");
our $radius=Gtk2::Entry->new;
	$radius->set_text("The number of left and right adjacent cells to be passed to the rule function.");
our $width=Gtk2::Entry->new;
	$width->set_text("The width of the inital array.");
our $gens=Gtk2::Entry->new;
	$gens->set_text("The number of generations for the automata to run.");
my $hbox1=Gtk2::HBox->new();
	my $frame1=Gtk2::Frame->new("Additional Options");
		our $random=Gtk2::CheckButton->new("Random automata start.");
			$random->set_active(TRUE);
			$random->show;
	my $frame2=Gtk2::Frame->new("Set text color.");
		my $colorsel1=Gtk2::ColorButton->new;
			our $textcolor=$colorsel1->get_color();
	my $frame3=Gtk2::Frame->new("Set background color.");
		my $colorsel2=Gtk2::ColorButton->new;
			our $backgroundcolor=$colorsel2->get_color();
my $hbox2=Gtk2::HBox->new();
	my $frame4=Gtk2::Frame->new("Click to begin.");
		my $buttontitle1="Generate";
		my $button1=Gtk2::Button->new_with_label($buttontitle1);
			$button1->signal_connect(clicked=>sub{rule110});
	my $frame5=Gtk2::Frame->new("Location of generated image.");
		our $filesavelocation=Gtk2::FileChooserButton->new('Select Location', 'select-folder');
$frame1->add($random);
$frame2->add($colorsel1);
$frame3->add($colorsel2);
$frame4->add($button1);
$frame5->add($filesavelocation);
$hbox1->add($frame1);
$hbox1->add($frame2);
$hbox1->add($frame3);
$hbox2->add($frame4);
$hbox2->add($frame5);
$VBox1->add($rule);
$VBox1->add($radius);
$VBox1->add($width);
$VBox1->add($gens);
$VBox1->add($hbox1);
$VBox1->add($hbox2);
$window1->add($VBox1);
$window1->show_all;
Gtk2->main;