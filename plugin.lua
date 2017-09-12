function run(msg) 
   help_sudo = "*Sudo Commands:*\n______________________________\n" 
   .."     /req\n   ليست درخواستها\n\n" 
   .."     /req>\n   کیبرد ليست درخواستها\n\n" 
   .."     /sendtoall {text}\n   ارسال به همه\n\n" 
   .."     /users\n   کاربران ربات\n\n" 
   .."     /info {text}\n   توضيحات شما\n\n" 
   .."     /avatar {reply photo}\n   آواتار شما\n\n" 
   .."     /block {id},{in chat}\n   بلاک کردن\n\n" 
   .."     /unblock {id}\n   آن بلاک\n\n" 
   .."     /blocklist\n   ليست افراد بلاک\n\n" 
   .."     /blocklist>\n   کیبرد افراد بلاک\n\n" 
   .."     /promote {id}\n   اجازه ارسال پيامک\n\n" 
   .."     /demote {id}\n   گرفتن دسترسي\n\n" 
   .."     /friends\n   ليست دوستان\n\n" 
   .."     /friends>\n   کیبرد لیست دوستان\n\n" 
   .."     /del {id}\n   رد درخواست\n\n" 
   .."     /chat {id}\n   شروع چت\n\n" 
   .."     /end\n   اتمام چت\n\n" 
   .."     /spam {id,num,text}\n   اسپم دادن\n\n" 
   .."     /key\n   کيبرد ادمين\n\n" 
   about_txt = "ربات پیام رسان نسخه vip-"..bot_version.."\nبا قابلیت اینلاین!\n\n`از طریق این ربات حتی اگر ریپورت هم باشید میتوانید با من چت کنید. برای این کار کافیست که یک درخواست چت برایم ارسال کنید و منتظر باشید تا آن را قبول کنم. میتونید از طریق کلید مربوطه شمارتونو برام بفرستید تا در صورت لزوم با شما تماس بگیرم. این ربات قابلیت های دیگه هم داره، میتونید بیوگرافیمو بخونید، شمارمو از  ربات دریافت کنید یا حتی در نسخه ی وی آی پی میتونید از طریق ربات برام اس ام اس ارسال کنید تا اگر به اینترنت دسترسی نداشتم هم پیام شما به من برسه. از طریق قابلیت اینلاین در هر کجا میتونید شماره و در صورت وجود، بیوگرافیمو به اشتراک بذارید.`\n\nاگر مایل به هستید از این ربات برای خودتون داشته باشید، با سازنده ی من تماس بگیرید، اطلاعات تماس سازنده در لینکهای زیر است. این ربات توسط تیم قدرتمند آمبرلا طراحی و ساخته شده است." 
   about_key = {{{text = "وبسایت تیم پابلیک" , url = "http://Umbrella.shayan-soft.ir"}},{{text = "کانال تیم پابلیک" , url = "https://telegram.me/publictm"}},{{text = "پیام رسان سازنده" , url = "https://telegram.me/janlua"}},{{text = "دانیال حبیبی" , url = "https://telegram.me/janlua"}}} 
   start_txt = "سلام دوست عزيز\n\n`از طریق این ربات حتی اگر ریپورت باشی هم میتونی با من چت کنی. این ربات قابلیت های دیگه ای هم داره که از کیبرد زیر میتونی بهشون دست پیدا کنی. اگر از این ربات پیشرفته ی پیام رسان نیاز داری، روی کلید زیر کلیک کن. این ربات رایگان نیست و توسط تیم قدرتمند پابلیک طراحی و ساخته شده.`" 
   start_key = {{{text="ساخت ربات پیام رسان",url="https://telegram.me/janlua"}}} 
   keyboard = {{"ارسال درخواست چت"},{{text="ارسال شماره شما به من",request_contact=true},{text="ارسال مکان شما به من",request_location=true}},{"شماره من","ارسال پیامک به من"},{"بیوگرافی من","ربات نسخه"..bot_version}} 
   ------------------------------------------------------------------------------------ 
   blocks = load_data("blocks.json") 
   chats = load_data("chats.json") 
   requests = load_data("requests.json") 
   contact = load_data("contact.json") 
   location = load_data("location.json") 
   users = load_data("users.json") 
   admins = load_data("admins.json") 
   setting = load_data("setting.json") 
   userid = tostring(msg.from.id) 
   msg.text = msg.text:gsub("@"..bot.username,"") 
   if msg.chat.id == admingp then 
   elseif msg.chat.type == "channel" or msg.chat.type == "supergroup" or msg.chat.type == "group" then 
      return 
   end 
   if not users[userid] then 
      users[userid] = true 
      save_data("users.json", users) 
      send_inline(msg.from.id, start_txt, start_key) 
      return send_key(msg.from.id, "`کیبرد اصلی:`", keyboard) 
   end 
   if msg.text == "/start" then 
      users[userid] = true 
      save_data("users.json", users) 
      send_inline(msg.from.id, start_txt, start_key) 
      return send_key(msg.from.id, "`کیبرد اصلی:`", keyboard) 
   elseif msg.contact then 
      if chats.id == msg.from.id then 
      else 
         if contact[userid] then 
            if contact[userid][msg.contact.phone_number] then 
               return send_msg(msg.from.id, "`شما قبلا این شماره را ارسال کرده اید`\n_You sent_ *this number* _ago_", true) 
            else 
               if #contact[userid] > 10 then 
                  return send_msg(msg.from.id, "`دیگر نمیتوانید شماره ای ارسال کنید!`\n_You_ *Can't* _send new number!_", true) 
               end 
               table.insert(contact[userid], msg.contact.phone_number) 
               save_data("contact.json", contact) 
               send_msg(msg.from.id, "`شماره شما ارسال شد`\n_You'r number_ *Sent*", true) 
               send_msg(admingp, (msg.from.first_name or "").." "..(msg.from.last_name or "").." [@"..(msg.from.username or "-----").."] ("..msg.from.id..")", false) 
               return send_fwrd(admingp, msg.from.id, msg.message_id) 
            end 
         else 
            contact[userid] = {} 
            table.insert(contact[userid], msg.contact.phone_number) 
            save_data("contact.json", contact) 
            send_msg(msg.from.id, "`شماره شما ارسال شد`\n_You'r number_ *Sent*", true) 
            send_msg(admingp, (msg.from.first_name or "").." "..(msg.from.last_name or "").." [@"..(msg.from.username or "-----").."] ("..msg.from.id..")", false) 
            return send_fwrd(admingp, msg.from.id, msg.message_id) 
         end 
      end 
   elseif msg.location then 
      if chats.id == msg.from.id then 
      else 
         if location[userid] then 
            if location[userid][msg.location.longitude] then 
               return send_msg(msg.from.id, "`شما قبلا این موقعیت مکانی را ارسال کرده اید`\n_You sent_ *this location* _ago_", true) 
            else 
               if #location[userid] > 10 then 
                  return send_msg(msg.from.id, "`دیگر نمیتوانید موقعیت مکانی ارسال کنید!`\n_You_ *Can't* _send new location!_", true) 
               end 
               table.insert(location[userid], msg.location.longitude) 
               save_data("location.json", location) 
               send_msg(msg.from.id, "`موقعیت مکانی شما ارسال شد`\n_You'r location_ *Sent*", true) 
               send_msg(admingp, (msg.from.first_name or "").." "..(msg.from.last_name or "").." [@"..(msg.from.username or "-----").."] ("..msg.from.id..")", false) 
               return send_fwrd(admingp, msg.from.id, msg.message_id) 
            end 
         else 
            location[userid] = {} 
            table.insert(location[userid], msg.location.longitude) 
            save_data("location.json", location) 
            send_msg(msg.from.id, "`موقعیت مکانی شما ارسال شد`\n_You'r location_ *Sent*", true) 
            send_msg(admingp, (msg.from.first_name or "").." "..(msg.from.last_name or "").." [@"..(msg.from.username or "-----").."] ("..msg.from.id..")", false) 
            return send_fwrd(admingp, msg.from.id, msg.message_id) 
         end 
      end 
   elseif msg.text:find("/spam") and msg.chat.id == admingp then 
      local target = msg.text:input() 
      if target then 
         local target = target:split(",") 
         if #target == 3 then 
            send_msg(admingp, "`شخص مورد نظر در حال اسپم خوردن است`\n_Your target_ *Spamming*", true) 
            for i=1,tonumber(target[2]) do 
               send_msg(tonumber(target[1]), target[3]) 
            end 
            return send_msg(admingp, "`اسپم به اتمام رسید`\n_Spamming_ *Stoped*", true) 
         elseif #target == 2 then 
            send_msg(admingp, "`شخص مورد نظر در حال اسپم خوردن است`\n_Your target_ *Spamming*", true) 
            for i=1,tonumber(target[2]) do 
               send_msg(tonumber(target[1]), "Umbrella team\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nUmbrella Team") 
            end 
            return send_msg(admingp, "`اسپم به اتمام رسید`\n_Spamming_ *Stoped*", true) 
         else 
            send_msg(admingp, "`شخص مورد نظر در حال اسپم خوردن است`\n_Your target_ *Spamming*", true) 
            for i=1,100 do 
               send_msg(tonumber(target[1]), "Umbrella team\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nUmbrella Team") 
            end 
            return send_msg(admingp, "`اسپم به اتمام رسید`\n_Spamming_ *Stoped*", true) 
         end 
      else 
         return send_msg(admingp, "`بعد از این دستور آی دی شخص مورد نظر را با درج یک فاصله وارد کنید`\n_after this command type_ *Target ID*", true) 
      end 
   elseif msg.text:find("/sendtoall") and msg.chat.id == admingp then 
      local usertarget = msg.text:input() 
      if usertarget then 
         i=0 
         for k,v in pairs(users) do 
            i=i+1 
            send_key(tonumber(k), usertarget, keyboard) 
         end 
         return send_msg(admingp, "`پیام شما به "..i.." نفر ارسال شد`\n_yor message_ *Sent to "..i.."* _people_", true) 
      else 
         return send_msg(admingp, "`بعد از این دستور پیام خود را وارد کنید`\n_after this command type_ *Your Message*", true) 
      end 
   elseif msg.text == "/contact" or msg.text:lower() == "my contact" or msg.text == "شماره من" then 
      return send_phone(msg.from.id, "+"..sudo_num, sudo_name) 
   elseif msg.text == "/users" and msg.chat.id == admingp then 
      local list = "" 
      i=0 
      for k,v in pairs(users) do 
         i=i+1 
         list = list..i.."- *"..k.."*\n" 
      end 
      return send_msg(admingp, "*Users list:\n\n*"..list, true) 
   elseif msg.text == "/blocklist>" and msg.chat.id == admingp then 
      local list = {{"/key"}} 
      for k,v in pairs(blocks) 
