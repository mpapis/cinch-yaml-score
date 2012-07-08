require 'yaml'

module Cinch
  module Plugins
    class YamlScore
      include Cinch::Plugin

      def initialize(*args)
        super
        if File.exist?('scores.yaml')
          @scores = YAML.load_file('scores.yaml')
        else
          @scores = {}
        end
      end

      match(/scores/, method: :scores)
      def scores(m)
        m.reply "Scores: #{@scores.sort_by{|k,v| -v }.map{|k,v| "#{k}: #{v}" }*", "}."
      end

      match(/score (\S+)/, method: :score)
      def score(m, nick)
        if @scores[nick]
          m.reply "Score for #{nick}: #{@scores[nick]}."
        else
          m.reply "No score for #{nick}."
        end
      end

      match(/(\S+) ([-+]1)/,    use_prefix: false, use_suffix: false, method: :change)
      match(/(\S+) ?([-+]{2})/, use_prefix: false, use_suffix: false, method: :change)
      def change(m, nick, score)
        if nick == m.user.nick
          m.reply "You can't score for yourself..."
        elsif nick == bot.nick
          m.reply "You can't score for me..."
        elsif m.channel.has_user?(nick)
          score.sub!(/([+-]){2}/,'\11')
          @scores[nick] ||= 0
          @scores[nick] += score.to_i
          @scores.delete(nick) if @scores[nick] == 0
          m.reply "#{m.user.nick}(#{@scores[m.user.nick]}) gave #{score} for #{nick}(#{@scores[nick]})."
          update_store
        elsif %w( , : ).include?(nick[-1]) && m.channel.has_user?(nick.slice(0..-2))
          nick.slice!(-1)
          score.sub!(/([+-]){2}/,'\11')
          @scores[nick] ||= 0
          @scores[nick] += score.to_i
          @scores.delete(nick) if @scores[nick] == 0
          m.reply "#{m.user.nick}(#{@scores[m.user.nick]}) gave #{score} for #{nick}(#{@scores[nick]})."
          update_store
        elsif config[:warn_no_user_message]
          m.reply config[:warn_no_user_message] % nick
        end
      end

      def update_store
        synchronize(:update) do
          File.open('scores.yaml', 'w') do |fh|
            YAML.dump(@scores, fh)
          end
        end
      end
    end
  end
end
