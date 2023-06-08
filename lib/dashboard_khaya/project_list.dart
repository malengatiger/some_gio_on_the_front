import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geo_monitor/library/api/prefs_og.dart';
import 'package:geo_monitor/realm_data/data/realm_sync_api.dart';
import 'package:realm/realm.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../library/data/project.dart';
import '../library/functions.dart';
import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;


class ProjectsHorizontal extends StatelessWidget {
  const ProjectsHorizontal(
      {Key? key,
      required this.realmSyncApi,
      required this.prefsOGx,
      required this.organizationId,
      required this.onProjectTapped})
      : super(key: key);
  final RealmSyncApi realmSyncApi;
  final PrefsOGx prefsOGx;
  final String organizationId;
  final Function(mrm.Project) onProjectTapped;

  @override
  Widget build(BuildContext context) {
    final Random random = Random(DateTime.now().millisecondsSinceEpoch);
    final images = getImages();

    return StreamBuilder<List<mrm.Project>>(
        stream: realmSyncApi.projectStream,
        builder: (ctx, snapshot) {
          var pList = <mrm.Project>[];
          if (snapshot.hasData) {
            pList = snapshot.data!;
          }
          return ScreenTypeLayout.builder(
            mobile: (ctx) {
              return SizedBox(
                  height: 220,
                  child: ListView.builder(
                    itemCount: pList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final project = pList.elementAt(index);
                      Image image;
                      if (index < images.length) {
                        image = images.elementAt(index);
                      } else {
                        final m = random.nextInt(images.length - 1);
                        image = images.elementAt(m);
                      }
                      return GestureDetector(
                        onTap: () {
                          pp('........ project tapped: ${project.name}');
                          onProjectTapped(project);
                        },
                        child: ProjectView(
                            image: image,
                            project: project,
                            height: 220,
                            width: 260),
                      );
                    },
                  ));
            },
            tablet: (ctx) {
              return OrientationLayoutBuilder(
                portrait: (context) {
                  return SizedBox(
                      height: 320,
                      child: ListView.builder(
                        itemCount: pList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final project = pList.elementAt(index);
                          Image image;
                          if (index < images.length) {
                            image = images.elementAt(index);
                          } else {
                            final m = random.nextInt(images.length - 1);
                            image = images.elementAt(m);
                          }
                          return GestureDetector(
                            onTap: () {
                              pp('........ project tapped: ${project.name}');
                              onProjectTapped(project);
                            },
                            child: ProjectView(
                                image: image,
                                project: project,
                                height: 312,
                                width: 312),
                          );
                        },
                      ));
                },
                landscape: (context) {
                  return SizedBox(
                      height: 220,
                      child: ListView.builder(
                        itemCount: pList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final project = pList.elementAt(index);
                          Image image;
                          if (index < images.length) {
                            image = images.elementAt(index);
                          } else {
                            final m = random.nextInt(images.length - 1);
                            image = images.elementAt(m);
                          }
                          return GestureDetector(
                            onTap: () {
                              pp('........ project tapped: ${project.name}');
                              onProjectTapped(project);
                            },
                            child: ProjectView(
                                image: image,
                                project: project,
                                height: 212,
                                width: 242),
                          );
                        },
                      ));
                },
              );
            },
          );
        });
  }
}

class ProjectView extends StatelessWidget {
  const ProjectView({
    Key? key,
    required this.project,
    required this.height,
    required this.width,
    required this.image,
  }) : super(key: key);
  final mrm.Project project;
  final double height, width;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        shape: getRoundedBorder(radius: 10),
        elevation: 2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      '${project.name}',
                      overflow: TextOverflow.ellipsis,
                      style: myTextStyleSmallBlackBold(context),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ClipRRect(borderRadius: BorderRadius.circular(10.0), child: image)
          ],
        ),
      ),
    );
  }
}
