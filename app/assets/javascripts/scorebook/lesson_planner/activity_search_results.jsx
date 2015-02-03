EC.ActivitySearchResults = React.createClass({
	


	render: function () {
		console.log(this.props)
		rows = _.map(this.props.activitySearchResults, function (ele) {
			var selected = _.include(this.props.selectedActivities, ele)
			
			return <EC.ActivitySearchResult data={ele} selected={selected} toggleActivitySelection={this.props.toggleActivitySelection} />
		}, this);
		return (
				<tbody>
					{rows}
				</tbody>
		);
	}


});