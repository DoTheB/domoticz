local teleTok   = '1011257173:AAGc3bXWtEwv5RDxn5ZpKx7vWUkOgsWDK_A'

local telegram ={};

    function telegram.sendText(chatId, message)
		if(chatId == 'Kai') then
			chatId = -1001378265145;
		end
		if(chatId == 'Silke') then
			--chatId =  ;
		end
		if(chatId == 'All') then
			chatId = -1001425255643;
		end
        return os.execute('curl --data chat_id='..chatId..' --data parse_mode=Markdown --data-urlencode "text='..message..'"  "https://api.telegram.org/bot'..teleTok..'/sendMessage" ')
    end

return telegram