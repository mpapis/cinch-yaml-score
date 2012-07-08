# Cinch YAML score plugin

A Cinch plugin to count +1, scores are saved in yaml file for persistence.

## Installation

First install the gem by running:

```bash
gem install cinch-yaml-score
```

Then load it in your bot:

```ruby
require "cinch"
require "cinch/plugins/yamlscore"

bot = Cinch::Bot.new do
  configure do |c|
    c.plugins.plugins = [Cinch::Plugins::YamlScore]
    # The following line is optional, if committed there will be no message.
    c.plugins.options[Cinch::Plugins::YamlScore] = { warn_no_user_message: "User %s is not in the channel, who do you want to score?" }
  end
end

bot.start
```

## Commands

```irc
!scores
!score <user>
<user>[,:]? [+-]1
<user>[,:]? ?[+-]{2}
```
