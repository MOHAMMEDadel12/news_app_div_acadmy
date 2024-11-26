
class ChatStates {}


/// Initial State
class ChatInitialState extends ChatStates{}

/// Get All Users States
class GetAllUsersLoadingState extends ChatStates{}
class GetAllUsersSuccessState extends ChatStates{}


/// Send Message States
class SendMessageLoadingState extends ChatStates{}
class SendMessageSuccessState extends ChatStates{}


/// Get Messages States
class GetMessagesLoadingState extends ChatStates{}
class GetMessagesSuccessState extends ChatStates{}



