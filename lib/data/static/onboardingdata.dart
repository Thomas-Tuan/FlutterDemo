import 'package:myapp/conf/const.dart';
import 'package:myapp/data/model/onboarding_model.dart';

List<OnBoardingModel> onBoarding = [
  OnBoardingModel(
    title: 'Đơn giản và vô cùng đa dạng',
    subTitle:
        'Đa dạng sản phẩm, đa dạng giá cả và tất cả đều được đảm bảo chất lượng',
    image: '$urlOnboardingImg' 'onboard-banner-1.gif',
  ),
  OnBoardingModel(
    title: 'Nền tảng cho sự phát triển',
    subTitle: 'Luôn đặt sự hài lòng của khách hàng là ưu tiên hàng đầu',
    image: '$urlOnboardingImg' 'onboard-banner-2.gif',
  ),
  OnBoardingModel(
    title: 'Được trải nghiệm dịch vụ mua sắm ',
    subTitle:
        'Nhân viên tích cực, thân thiện và luôn sẵn sàng tiếp đón khách hàng',
    image: '$urlOnboardingImg' 'onboard-banner-3.gif',
  ),
];
