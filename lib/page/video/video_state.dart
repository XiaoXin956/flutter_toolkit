part of 'video_cubit.dart';

sealed class VideoState extends Equatable {
  const VideoState();
}

final class VideoInitial extends VideoState {
  @override
  List<Object> get props => [];
}
