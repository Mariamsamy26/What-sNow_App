import 'package:bloc/bloc.dart';
import 'package:social_share/social_share.dart';

import 'ShareSetup.dart';

class ShareLogic extends Cubit<ShareState> {
  ShareLogic() : super(InitShare());


  whatsAppShare({required Uri link}) {
    SocialShare.shareWhatsapp(link.toString());
    emit(WhatsApp_Share());
  }

  twitterShare({required Uri link}) {
    SocialShare.shareTwitter(link.toString());
    emit(Twitter_Share());
  }

  smsShare({required Uri link}) {
    SocialShare.shareSms(link.toString());
    emit(Sms_Share());
  }

  telegramShare({required Uri link}) {
    SocialShare.shareTelegram(link.toString());
    emit(Telegram_Share());
  }



}
