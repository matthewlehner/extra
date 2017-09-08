declare type Extra$PostCollection = {
  id: string,
  name: string
};

declare type Extra$Channel = {
  id: string,
  provider: string,
  name: string,
  image?: string
}

declare type Extra$QueuedPost = {
  id: string,
  scheduledFor: Date,
  postContent: Extra$PostContent
};

declare type Extra$PostContent = {
  body: string
};
