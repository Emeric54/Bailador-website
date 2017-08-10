use v6.c;

use Bailador;

use JSON::Fast;
use LWP::Simple;
use Text::Markdown;

my $root = $*PROGRAM.absolute.IO.dirname;
$root = $root.IO.dirname;

my $ressources-md = 'https://raw.githubusercontent.com/Bailador/Ressources/master/README.md';

get '/documentation' => sub () {
    my $code = "$root/tmp/documentation.html".IO.slurp: :close;
    return template("documentation.html", {
        code => $code,
    });
};

get '/dependencies' => sub {
    return template "dependencies.html";
};

get '/deps' => sub {
    redirect('/dependencies');
}

get '/ressources' => sub {
    my $raw-md = LWP::Simple.get($ressources-md);
    my $md = Text::Markdown.new($raw-md);
    my $code = $md.render;
    return template("ressources.html", {
        code => $code,
   });
}

require Bailador::Gradual;

baile();

# vim: expandtab
# vim: tabstop=4
