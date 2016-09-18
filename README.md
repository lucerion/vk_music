# VKMusic

vk.com (vkontakte) music downloader and synchronizer


## Installation

``` sh
git clone https://github.com/lucerion/vk_music.git
cd ./vk_music
bundle install
```


## Usage

Execute `./bin/vk_music`


### Options

```
-u, --user EMAIL             user email. Required
-p, --password PASSWORD      user password
-a, --app-id NUMBER          application ID. Required
-d, --directory PATH         download directory. Default: /path/to/vk_music/audio
    --count NUMBER           amount of audio files
    --offset NUMBER          skip N audio files
    --filename TEMPLATE      file name template. Default: %{artist} - %{title}.mp3
    --version                display version
    --help                   display a usage message
```


## License

[BSD-3-Clause](https://opensource.org/licenses/BSD-3-Clause)
