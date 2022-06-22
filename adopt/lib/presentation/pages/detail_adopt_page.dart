import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/presentation/blocs/detail_adopt_bloc/detail_adopt_bloc.dart';
import 'package:adopt/presentation/widgets/custom_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notification/notification.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailAdoptPage extends StatefulWidget {
  final String petAdoptId;
  const DetailAdoptPage({Key? key, required this.petAdoptId}) : super(key: key);

  @override
  State<DetailAdoptPage> createState() => _DetailAdoptPageState();
}

class _DetailAdoptPageState extends State<DetailAdoptPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailAdoptBloc>(context)
        .add(FetchPetDescription(petId: widget.petAdoptId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            color: kPrimaryColor,
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Detail Pet',
            style: kTextTheme.headline5,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<DetailAdoptBloc, DetailAdoptState>(
              listener: (context, state) {
            if (state is SuccessRequestAdopt) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          }, builder: (context, state) {
            if (state is DetailAdoptLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PetDescriptionLoaded) {
              return _BuildDetailAdopt(
                adoptEntity: state.adoptEntity,
                isOwner: state.isOwner,
              );
            } else if (state is DetailAdoptError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center();
            }
          }),
        ));
  }
}

class _BuildDetailAdopt extends StatelessWidget {
  final AdoptEntity adoptEntity;
  final bool isOwner;
  const _BuildDetailAdopt({
    required this.adoptEntity,
    required this.isOwner,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(kPadding * 2),
            decoration: BoxDecoration(
              color: kGrey,
              borderRadius: BorderRadius.circular(10),
              image: adoptEntity.petPictureUrl != "" &&
                      adoptEntity.petPictureUrl != null
                  ? DecorationImage(
                      image: NetworkImage(adoptEntity.petPictureUrl ?? ''),
                      fit: BoxFit.cover)
                  : null,
            ),
            child: adoptEntity.petPictureUrl == "" ||
                    adoptEntity.petPictureUrl == null
                ? const Icon(Icons.image)
                : null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          adoptEntity.petName ?? '-',
                          style: kTextTheme.headline4,
                        ),
                        Text(
                          adoptEntity.petType ?? '-',
                          style: kTextTheme.bodyText2?.copyWith(
                              height: 1, fontSize: 14, color: kGreyTransparant),
                        ),
                      ],
                    ),
                  ),
                  adoptEntity.certificateUrl != "" &&
                          adoptEntity.certificateUrl != null
                      ? InkWell(
                          onTap: () async {
                            if (!await launchUrlString(
                              adoptEntity.certificateUrl!,
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw 'Could not launch ${adoptEntity.certificateUrl!}';
                            }
                          },
                          child: Container(
                            height: 32,
                            width: 41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: kPrimaryColor,
                            ),
                            padding: const EdgeInsets.all(3),
                            child: SvgPicture.asset(
                                'assets/icons/certificate_icon.svg'),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCardDescPet(
                    'Gender',
                    adoptEntity.gender ?? '-',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildCardDescPet(
                    'Age',
                    adoptEntity.dateOfBirth != null ? _getAge() : '-',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildCardDescPet(
                    'Breed',
                    adoptEntity.petBreed != '' && adoptEntity.petBreed != null
                        ? adoptEntity.petBreed!
                        : '-',
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                adoptEntity.petDescription ?? '',
                style: kTextTheme.bodyText1
                    ?.copyWith(fontSize: 14, color: kGreyTransparant),
              ),
              !isOwner
                  ? Container(
                      height: 52,
                      margin: const EdgeInsets.symmetric(vertical: kPadding),
                      width: double.infinity,
                      child: Row(
                        children: [
                          (adoptEntity.whatsappNumber != null &&
                                  adoptEntity.whatsappNumber != '')
                              ? InkWell(
                                  onTap: () async {
                                    if (!await launchUrlString(
                                      'https://wa.me/${adoptEntity.whatsappNumber!}',
                                      mode: LaunchMode.externalApplication,
                                    )) {
                                      throw 'Could not launch ${adoptEntity.whatsappNumber!}';
                                    }
                                  },
                                  child: Container(
                                    width: 52,
                                    height: 52,
                                    margin:
                                        const EdgeInsets.only(right: kPadding),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1, color: kPrimaryColor)),
                                    child: const Icon(
                                      Icons.whatsapp,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                )
                              : Container(),
                          Expanded(
                            child: GradientButton(
                              height: 52,
                              width: 100,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: kBorderRadius,
                                        ),
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        child: CustomDialog(
                                            desc:
                                                'Adopt request sent to pet owner',
                                            title: 'Success',
                                            buttons: [
                                              DialogButton(
                                                  text: 'OK',
                                                  func: () {
                                                    final notif =
                                                        NotificationEntity(
                                                      title:
                                                          'Request For Adopt',
                                                      value:
                                                          'some people want to adopt your pet',
                                                      type: 'adopt',
                                                      readStatus: false,
                                                      sendTime:
                                                          Timestamp.fromDate(
                                                              DateTime.now()),
                                                    );
                                                    BlocProvider.of<
                                                                DetailAdoptBloc>(
                                                            context)
                                                        .add(RequestAdopt(
                                                            adoptEntity:
                                                                adoptEntity));
                                                    BlocProvider.of<
                                                                SendNotifBloc>(
                                                            context)
                                                        .add(SendAdoptNotification(
                                                            ownerId: adoptEntity
                                                                .userId!,
                                                            notificationEntity:
                                                                notif));
                                                  },
                                                  type: 'submit'),
                                            ]),
                                      );
                                    });
                              },
                              text: 'Adopt Now',
                              isClicked: false,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      height: 52,
                      margin: const EdgeInsets.symmetric(vertical: kPadding),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Container(
                                width: 100,
                                height: 52,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: kPrimaryColor)),
                                child: Center(
                                  child: Text('Edit Data',
                                      style: kTextTheme.subtitle1
                                          ?.copyWith(color: kPrimaryColor)),
                                ),
                              ),
                              onTap: () => Navigator.pushNamed(
                                  context, EDIT_ADOPT_ROUTE_NAME,
                                  arguments: adoptEntity),
                            ),
                          ),
                          const SizedBox(
                            width: kPadding,
                          ),
                          Expanded(
                            child: GradientButton(
                              height: 52,
                              width: 100,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ACTIVITY_STATUS_ROUT_NAME);
                              },
                              text: 'Check Status',
                              isClicked: false,
                            ),
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardDescPet(String type, String content) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(kPadding),
        decoration: BoxDecoration(
            borderRadius: kBorderRadius,
            border: Border.all(width: 1, color: kGrey)),
        height: 68,
        child: Column(
          children: [
            Text(
              type,
              style: kTextTheme.bodyText2,
            ),
            Text(content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kTextTheme.subtitle1
                    ?.copyWith(color: Colors.black54, fontSize: 14))
          ],
        ),
      ),
    );
  }

  String _getAge() {
    DateTime? born = adoptEntity.dateOfBirth?.toDate();
    DateTime today = DateTime.now();
    int yearDiff = today.year - (born?.year ?? 0);
    int monthDiff = today.month - (born?.month ?? 0);
    int dayDiff = today.day - (born?.day ?? 0);

    String age = '';
    if (yearDiff > 0) {
      age += yearDiff.toString();
      int percentMonth = (monthDiff / 12).round();
      age += percentMonth > 0 ? '.$percentMonth' : '';
      age += ' Year';
    } else if (monthDiff > 0) {
      age += '$monthDiff Month';
    } else {
      age += '$dayDiff Day';
    }
    return age;
  }
}
