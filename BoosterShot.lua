local f = CreateFrame("Frame")

f:SetScript("OnEvent", function(self, event, ...)
  if self[event] then return self[event](self, ...); end
end)

f:RegisterEvent("CHAT_MSG_TEXT_EMOTE")

function f:CHAT_MSG_TEXT_EMOTE(...)
  local msg = select(1, ...)
  -- TODO: Do party/guild/friend check here first
  if ( string.lower(string.sub(msg,string.len(msg)-13,string.len(msg))) == "you to follow.") then
    FollowUnit(select(2, ...));
  end
end


f:RegisterEvent("RESURRECT_REQUEST")

function f:RESURRECT_REQUEST(...)
  AcceptResurrect();
end


f:RegisterEvent("PARTY_INVITE_REQUEST")

function f:PARTY_INVITE_REQUEST(...)
  AcceptGroup();
  self:RegisterEvent("PARTY_MEMBERS_CHANGED");
end

function f:PARTY_MEMBERS_CHANGED(...)
  StaticPopup_Hide("PARTY_INVITE");
  self:UnregisterEvent("PARTY_MEMBERS_CHANGED");
end
