import 'package:flutter/material.dart';
import 'package:my_boxy_ds/my_boxy_ds.dart';

class OnboardingTypeCarouselView extends StatefulWidget {
  const OnboardingTypeCarouselView({super.key});

  @override
  State<OnboardingTypeCarouselView> createState() =>
      _OnboardingTypeCarouselViewState();
}

class _OnboardingTypeCarouselViewState
    extends State<OnboardingTypeCarouselView> {
  final ValueNotifier<bool> _isProfileValid = ValueNotifier<bool>(false);

  static const _items = <MBOnboardingCarouselItem<String>>[
    MBOnboardingCarouselItem(title: 'Bem-vindo', data: 'welcome'),
    MBOnboardingCarouselItem(title: 'Seu perfil', data: 'profile'),
    MBOnboardingCarouselItem(title: 'Tudo pronto', data: 'complete'),
  ];

  @override
  void dispose() {
    _isProfileValid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: MBOnboardingTypeCarousel<String>(
        items: _items,
        itemBuilder: (context, item, index) => switch (item.data) {
          'welcome' => const _OnboardingMessage(
            title: 'Organize sua jornada',
            description: 'Conheça recursos feitos para simplificar seu dia.',
            icon: Icons.auto_awesome_outlined,
          ),
          'profile' => _ProfileForm(
            onValidityChanged: (isValid) => _isProfileValid.value = isValid,
          ),
          _ => const _OnboardingMessage(
            title: 'Pronto para começar',
            description: 'Seu espaço está preparado para você.',
            icon: Icons.check_circle_outline,
          ),
        },
        display: MBOnboardingCarouselDisplay.peek,
        bottomWidgetsBuilder:
            (context, item, index, onNext, onPrevious, onExit) => [
              ValueListenableBuilder<bool>(
                valueListenable: _isProfileValid,
                builder: (context, isProfileValid, child) => MBMainButton(
                  title: index == _items.length - 1 ? 'Concluir' : 'Continuar',
                  buttonType: item.data == 'profile' && !isProfileValid
                      ? MBMainButtonType.disabled
                      : MBMainButtonType.normal,
                  onPressed: item.data == 'profile' && !isProfileValid
                      ? null
                      : onNext,
                ),
              ),
              if (index < _items.length - 1)
                Padding(
                  padding: const EdgeInsets.only(top: AppSizes.small),
                  child: MBMainButton(
                    title: 'Pular',
                    buttonType: MBMainButtonType.outlined,
                    onPressed: onExit,
                  ),
                ),
            ],
        onExit: (context) => Navigator.of(context).pop(),
      ),
    );
  }
}

class _OnboardingMessage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _OnboardingMessage({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: AppSizes.xxl,
            backgroundColor: AppColors.primaryLight,
            child: Icon(icon, size: AppSizes.xl, color: AppColors.primaryDark),
          ),
          const SizedBox(height: AppSizes.xl),
          Text(
            title,
            style: AppTextStyles.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.medium),
          Text(
            description,
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ProfileForm extends StatefulWidget {
  final ValueChanged<bool> onValidityChanged;

  const _ProfileForm({required this.onValidityChanged});

  @override
  State<_ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<_ProfileForm> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Como quer ser chamado?', style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSizes.medium),
          TextField(
            controller: _nameController,
            onChanged: (value) =>
                widget.onValidityChanged(value.trim().isNotEmpty),
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
        ],
      ),
    );
  }
}
