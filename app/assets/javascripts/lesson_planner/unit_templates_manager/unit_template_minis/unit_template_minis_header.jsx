EC.UnitTemplateMinisHeader = React.createClass({
  propTypes: {
    data: React.PropTypes.object.isRequired
  },

  stateSpecificComponent: function () {
    var grade = this.props.data.grade;
    if (grade) {
      return "Perfect For Your Grade " + grade + " Class";
    } else {
      return "Featured Activity Packs"
    }
  },

  render: function () {
    return (
      <div className='unit-template-minis-header'>
        <h1>{this.stateSpecificComponent()}</h1>
        <h3>Activity Packs are a simple way to assign a group of activities to students quickly. More time teaching, less time clicking.</h3>
      </div>
    )
  }
})