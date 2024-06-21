To make everything run on Windows smoothly, one needs to install more than just the defaults using the RubyInstaller for Windows.
When asked for options, do not go with the default - pick everything, otherwise it will not be possible to build gem native extensions.

Also, it seems that ruby-lsp extension does not cooperate with blank VS Code solutions; it needs to have a folder workspace open, with a Gemfile.lock in it.
There was another problem though, because _bundle install_ did not work either, due to missing development toolchains. I managed to solve it by installing
all options via ridk:

![image](https://github.com/b4ry/RubyTest/assets/3950530/76f812f3-702b-4dbd-97d4-d323d947c502)

I wrote a Medium article with some more details, if one needs: https://medium.com/@luka.barczak/initial-ruby-lsp-configurational-pain-7d58bba2b995
