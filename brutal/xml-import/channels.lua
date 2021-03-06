ImportXML
[[
<triggers
   muclient_version="4.90"
   world_file_version="15"
   date_saved="2017-03-05 19:00:00"
  >
  <trigger
   enabled="y"
   group="brutal_comms_group"
   keep_evaluating="y"
   match="^(?&lt;player&gt;\S+) (\{|\[|\&lt;)(?&lt;channel&gt;\S+)(\}|]|\&gt;): (?&lt;text&gt;.+$)"
   name="brutal_msg"
   regexp="y"
   script="brutal_channel_msg"
   sequence="100"
  >
  </trigger>
  <trigger
   enabled="y"
   group="brutal_comms_group"
   keep_evaluating="y"
   match="^(\[|\{)(?&lt;channel&gt;\S+)(\]|})\:(?&lt;emote&gt;.+$)"
   name="brutal_emote"
   regexp="y"
   script="brutal_channel_msg"
   sequence="100"
  >
  </trigger>
  <trigger
   enabled="y"
   group="brutal_comms_group"
   keep_evaluating="y"
   match="^From afar you see.+"
   name="tell_emote_from_someone"
   regexp="y"
   script="brutal_tell"
   sequence="100"
  >
  </trigger>
  <trigger
   custom_colour="17"
   enabled="y"
   group="brutal_comms_group"
   keep_evaluating="y"
   match="^You send afar.+$"
   name="tell_emote_from_me"
   regexp="y"
   script="brutal_tell"
   sequence="100"
   other_text_colour="lime"
  >
  </trigger>
  <trigger
   enabled="y"
   group="brutal_comms_group"
   keep_evaluating="y"
   match="^\S+ tells you .+$"
   name="tell_msg_from_someone"
   regexp="y"
   script="brutal_tell"
   sequence="100"
  >
  </trigger>
  <trigger
   custom_colour="17"
   enabled="y"
   group="brutal_comms_group"
   ignore_case="y"
   keep_evaluating="y"
   match="^You tell (.*?)$"
   name="tell_msg_from_me"
   regexp="y"
   repeat="y"
   script="brutal_tell"
   sequence="90"
   other_text_colour="lime"
  >
  </trigger>
</triggers>
]]
