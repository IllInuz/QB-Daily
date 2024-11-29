# QB-DailyRewards

A lightweight daily rewards system for QBCore servers. Players can claim daily rewards using a simple command, with support for multiple inventory systems.

## Features
- Configurable rewards (items and money) 
- Random reward selection with custom probability weights
- 24-hour cooldown per player
- Support for QB/OX/QS inventories
- MySQL tracking to prevent abuse
- Simple `/dailyreward` command

## Dependencies
- QBCore Framework
- oxmysql
- One of the following inventories:
 - qb-inventory
 - ox_inventory
 - qs-inventory

## Installation

1. Clone the repository:
\```bash
cd resources/[qb]
git clone https://github.com/yourusername/qb-dailyrewards.git
\```

2. Configure your inventory system in `config.lua`:
\```lua
Config.InventoryType = "qb" -- Options: "qb", "ox", "qs"
\```

3. Configure rewards in `config.lua`:
\```lua
Config.Rewards = {
   {type = "item", name = "phone", amount = 1, chance = 10},
   {type = "item", name = "lockpick", amount = 2, chance = 30},
   {type = "money", amount = 1000, chance = 40},
   {type = "money", amount = 2000, chance = 20}
}
\```

4. Add to your `server.cfg`:
\```
ensure qb-dailyrewards
\```

## Usage

Players can use the `/dailyreward` command once every 24 hours to receive a random reward.

## Configuration

### Adding New Rewards
Add new entries to the `Config.Rewards` table in `config.lua`:
\```lua
{type = "item", name = "ITEM_NAME", amount = AMOUNT, chance = CHANCE},
\```
- `type`: "item" or "money"
- `name`: Item spawn name (for items only)
- `amount`: Quantity to give
- `chance`: Relative probability weight

## Contributing

1. Fork the repository
2. Create a new branch for your feature:
\```bash
git checkout -b feature/YourFeatureName
\```
3. Make your changes
4. Test your changes thoroughly
5. Commit with clear messages:
\```bash
git commit -m "feat: add new reward type"
\```
6. Push to your fork:
\```bash
git push origin feature/YourFeatureName
\```
7. Open a Pull Request with:
  - Clear description of changes
  - Any relevant issue numbers
  - Screenshots/videos if applicable

## License
NFRL - See LICENSE file for details

## Support
- Open an issue for bugs/features

## Changelog
### v1.0.0
- Initial release
- Multi-inventory support
- Basic reward system
