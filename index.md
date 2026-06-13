---
layout: page
title: Five Nights at Lodge
permalink: /
hide_title: true
---

# Unturned Lodge | Relaxed PvE • No Raiding • EU/GER

## Server Mods 
- [California 2](https://steamcommunity.com/sharedfiles/filedetails/?id=3707778928)
- [California 2 Assets](https://steamcommunity.com/sharedfiles/filedetails/?id=3711646503)
- [Dingus](https://steamcommunity.com/sharedfiles/filedetails/?id=2903473715)
- [More Farming Mod - Core](https://steamcommunity.com/sharedfiles/filedetails/?id=3729650953)
- [More Farming Mod - California 2](https://steamcommunity.com/sharedfiles/filedetails/?id=3734459367)
- [Zoidberg FM Cali](https://steamcommunity.com/sharedfiles/filedetails/?id=3723007714)

## Server Commands

### General commands

|Command                |Description                                    |Cooldown           |
|:---                   |:---                                           |        :---:      |
| `/home`               |Teleport the player to his claimed home, if any|60s *(see notes)*  |
| `/tpa <player name>`  |Request to teleport to specific player         |30s                |
| `/tpa c[ancel]`       |Abort teleport request                         |                   |
| `/tpa a[ccept]`       |Accept teleport request from other player      |                   |
| `/tpa d[ecline]`      |Decline teleport request from other player     |                   |

**Notes:**
- `/home` cooldown depends on your player rank; see [Donate](/donate) page for more details

### Kits commands

|Command                |Description                                            |Cooldown   |
|:---                   |:---                                                   |   :---:   |
| `/kit license`        |Gives to the player two license plate for vehicle mark |1H         |

### Vote commands

|Command    |Description                                        |Cooldown   |
|:---       |:---                                               |   :---:   |
| `/vote`   |Open the vote page on unturned-servers.net         |24H        |
| `/reward` |Claim a reward after a vote on unturned-servers.net|24H        |

### Shop commands

|Command                                    |Description                                        |
|:---                                       |:---                                               |
| `/balance`                                |Show the current balance of the player             |
| `/pay <player name> <amount>`             |Pay the specific amount to selected player         |
| `/buy <item id\|item name> [<quantity>]`  |Buy an item with optional quantity from the shop   |
| `/sell <item id\|item name> [<quantity>]` |Sell an item with optional MAX quantity on the shop|
| `/buy v.<vehicle id\|vehicle name>`       |Buy a vehicle from the shop                        |

**Notes:**
- Item name can be specified partially (e.g. *Alicep*): the shop do the following logic: 
    1. Search an item with exact name match
    2. Search items with the name that starts with given name
    3. Search items with the name that contains given name

- If the item name contains a space you have to enclose it between double quotes, like: "military magaz"
- The item name search is case insensitive
- When you sell items with desired quantity, the shop try to sell all the items in your backpack till the desired quantity: if you have less than desired quantity the shop still sell every item it found


