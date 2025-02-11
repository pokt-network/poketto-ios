# Poketto 👛

![Design](https://user-images.githubusercontent.com/407470/56584925-b5dad380-65d4-11e9-87e5-3b9b356a7a4e.png)

Poketto is the simplest xDai wallet for your day-to-day transactions.

Our goal with Poketto is to make it easy to send money to friends and pay for every day items.
It's your pocket wallet inside your phone with secure and near instant transactions.

Download now on the [App Store](https://itunes.apple.com/us/app/poketto-cash/id1460141974)

## Features

- Send xDai to an address or saved contacts
- Request xDai via QR code or share
- List, categorize and search for transactions
- Set addresses to contacts
- Near instant transactions (< 5 seconds)
- Import and export your wallet

## Contribute

### Setup

Clone the project and install the required dependencies via cocoapods with:

`pod install`

Open `Poketto.xcworkspace` and you're ready 🎉

### Development

In order to generate classes automatically for Core Data we use mogenerator.
Install via:

`brew install mogenerator`

and uncomment the run script:

`mogenerator -m Poketto/data/db.xcdatamodeld/db.xcdatamodel -O Poketto/data/Models/Generated --swift --template-var arc=true`

### Guidelines

Work in progress 🏗

## Project board

You can keep track of what is happening on this project by heading over to our [project board](https://github.com/orgs/pokettocash/projects/1) here on github.

## Roadmap

To get an overview of our quarterly status head over to [our roadmap](https://www.notion.so/donesunday/bd48985b027e4619b678b0b8ece279fb?v=89f353f020614cc7a87ea015e859daee).

## Donations

Donations enable us to continue boostrastrapping Poketto's development.

ERC20 Tokens or xDai

Address: `0x3849bA8A4D7193bF550a6e04632b176F9Ce1B7e8`

Thank you for your support! ♥

## License

poketto-ios is under the GPLv3 and the MPLv2 license.

See [LICENSE](https://github.com/pokettocash/poketto-ios/blob/master/LICENSE) for more license info.

---

Made at [Done Sunday](http://donesunday.com/) 🌞 by [@_andre_sousa](https://twitter.com/_andre_sousa), [@alvesjtiago](https://twitter.com/alvesjtiago) and [@jackveiga](https://twitter.com/jackveiga).

Join us on [Discord](https://discord.gg/6SrsfUf) to help shape Poketto's future.
