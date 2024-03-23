import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  initialize() {}
  connect() {}
  toggleEditForm(event) {
    event.preventDefault();
    event.stopPropagation();

    const editFormID = event.params['editform'];
    const commentBodyID = event.params['body'];

    const editForm = document.getElementById(editFormID);
    editForm.classList.toggle('hidden');

    const commentBody = document.getElementById(commentBodyID);
    commentBody.classList.toggle('hidden');
  }
}
