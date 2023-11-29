part of carp_study_app;

class InvitationsListViewModel extends ViewModel {
  Future<List<ActiveParticipationInvitation>> get invitations async {
    bloc.invitations =
        await CarpParticipationService().getActiveParticipationInvitations();

    /// Filter the invitations to only include those that
    /// have a smartphone as a device in [ActiveParticipationInvitation.assignedDevices] list
    /// (i.e. the invitation is for a smartphone).
    /// This is done to avoid showing invitations for other devices (e.g. [WebBrowser]).
    bloc.invitations = bloc.invitations
        .where((invitation) =>
            invitation.assignedDevices
                ?.any((device) => device.device is Smartphone) ??
            false)
        .toList();

    return bloc.invitations;
  }

  InvitationsListViewModel();
}
