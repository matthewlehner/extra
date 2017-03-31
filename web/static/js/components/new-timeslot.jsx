import React, { Component } from "react";

export default class NewTimeslot extends Component {
  showForm = (event) => {
    event.preventDefault();
    this.setState(() => ({ showForm: true }));
  }

  render() {
    if (this.state && this.state.showForm) {
      return (
        <form>
          <input type="text" placeholder="08:00" />
          <select>
            <option value="MONDAYS">Only Mondays</option>
          </select>
          <select>
            <option value="3">Collection Name</option>
          </select>
        </form>
      );
    }

    return <button onClick={this.showForm}>Add new time slot</button>;
  }
}

