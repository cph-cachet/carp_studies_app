part of carp_study_app;

class InvitationsListViewModel extends ViewModel {
  Future<List<ActiveParticipationInvitation>> get invitations async {
    bloc.invitations = await CarpParticipationService().getActiveParticipationInvitations();
    return bloc.invitations;
  }


  InvitationsListViewModel();
}
