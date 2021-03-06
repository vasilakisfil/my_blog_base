## What is Octopress
An amazing blogging platform. See more at: [Octopress.org](http://octopress.org)

## What is Modified Octopress
After trying Wordpress "I wanna do everything" which was way too complex for simple
things and Tumblr "I wanna be professional" which contained numerous bugs and ended
up in a semi-porn site, I wanted to try something more simple. I landed up in
Octopress and haven't regreted since then.

So Modified Octopress is exactly Octopress with some improvements/adjustements
I made to make my life easier.

## How much modified is this version of Octopress?
Well not much. The only but important thing that I wanted to do was to completely
serparate content from presentation. Using Octopress this can't be achieved entierely.
However what I did is to have 3 different repositories:

1. The Octopress platform (my_blog_base):
    - This repository holds the main Octopress files.
2. My Octopress theme (my_blog_theme):
    - This repo holds the presentation files
3. My Markdown Posts


After trying git submodules, fake submodules I ended up doing this:

1. I added in .gitignore of repo1 the location or repo2 and repo3.
2. Then I created the 2 others repo and update them asychronously from times to times.


The only problem was that I wanted my markdown posts to be TOTALLY platform agnostic.
So I modified the Rakefile of Octopress to create a new folder in source/images/post_images/
folder with the date-name of the post in order to store any image I may need there.

Also I added one more folder: source/other_files and created other_files plugin in order
to upload.. well any other file that I might need in a post. When you create a new post,
as in the case of images, rake auto creates a post specific folder with the post's name
as the folder name.

Due to the strange nature of Jekyll/Octopress when you install a theme all the theme's
files in .theme/your_theme are copied in source/ folder. So (among others) I appended
the 2 unecessary folders of theme .gitignore, that is, source/ and sass/. Now in the
source folder I create a new repo that ignores ALL
folders except _posts/, images/post_images/ and source/other_files.

Yeah I know, a bit complicated but now 2 things happen:

1. I don't re-add unecessary files in my repo such as source/ and sass/ as most people do.
These files are in your theme and are copied in these folders when you hit
rake install["your_theme"].
2. If for some reason tomorrow I want to leave behind Octopress I have my posts
with their images in an external repo and I can do them anything I want :)


## How to install

```
$ git clone https://github.com/vasilakisfil/my_blog_base.git
$ bundle install
$ vim .gitignore #edit the last line and add your theme name
$ git clone theme_repo .themes/theme_repo
$ git clone posts_repo source
$ rake install["theme_repo"] # you may need to add noglob before rake command if you use zsh
 #creates_posts/xxxx-xx-xx-new-post.markdown and
 #creates images/post/images/xxxx-xx-xx-new-post folder to hold images
$ rake new_post["new_post"]
 #edit your post and add images
$ rake generate
$ rake preview
```

##  Tips
If you are using this configuration for the first time, then in for your posts repo,
in an empty folder just hit git init and add these in your .gitignore file:

    _includes/
    _layouts/
    !_posts/
    assets/
    atom.xml
    blog/
    crossdomain.xml
    favicon.png # depends on the theme
    humans.txt
    images/*
    !images/post_images/
    index.html
    javascripts/
    robots.txt
    stylesheets/

Then do exactly as said above and when you create a new post, inside source/
folder git status will pinpoint to you to add _source/_posts and source/images/ folders.

Also since in Markdown there are no variables I modified Rakefile to add you
in the first line of your post this:

    <!-- for images path: /images/post_images/xxxx-xx-xx-new-post -->

so that you can copy/paste it when you want to add a new image path.

### Dual Screen Support ###
If you want dual screen support then you have to edit the file /usr/local/bin/guake and in
912 (window_rect.y = 0) add the following:

    window_rect.y = screen.get_monitor_geometry(0)[1]
    window_rect.x = 0

