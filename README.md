# es-search-games

## General Usage

Shell script to search for games across all installed systems in retropie. The search will be cached. Can be installed in the retropiemenu in emulationstation.

## Prerequisites

Dialog has to be installed.

```
sudo apt-get update
sudo apt-get install dialog
```

## Configuration

```searchgames.sh``` script should be placed in: ```/home/pi/RetroPie/retropiemenu```

Add following item to: ```/opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml```
```xml
<game>
    <path>./searchgames.sh</path>
    <name>Search game(s) in collection</name>
    <desc>Search game(s) in all systems.</desc>
    <image>./icons/searchgames.png</image>
</game>
```

## Icon
Icon can be found here: ```http://www.iconarchive.com/show/flatastic-1-icons-by-custom-icon-design/search-icon.html```

and should be placed here: ```/home/pi/RetroPie/retropiemenu/icons```

## Screenshots
![alt text](https://github.com/pariziv/es-search-games/blob/master/screenshots/screenshot1.png)

![alt text](https://github.com/pariziv/es-search-games/blob/master/screenshots/screenshot2.png)

![alt text](https://github.com/pariziv/es-search-games/blob/master/screenshots/screenshot3.png)

![alt text](https://github.com/pariziv/es-search-games/blob/master/screenshots/screenshot4.png)

![alt text](https://github.com/pariziv/es-search-games/blob/master/screenshots/screenshot5.png)

![alt text](https://github.com/pariziv/es-search-games/blob/master/screenshots/screenshot6.png)

![alt text](https://github.com/pariziv/es-search-games/blob/master/screenshots/screenshot7.png)

![alt text](https://github.com/pariziv/es-search-games/blob/master/screenshots/screenshot8.png)



