import React from 'react';

class NewOperationForm extends React.Component {
  state = {
    type: 'income',
    disabled: false
  }

  errorsBlock = () => {
    let errors_length = this.props.errors.length;

    if(errors_length > 0) {
      return (
        <div id="error_explanation">
          <h2>{`${errors_length} ${errors_length > 1 ? 'errors' : 'error'}`} prohibited this operation from being saved:</h2>
          <ul>
            {this.props.errors.map((err, idx) => <li key={idx}>{err}</li>)}
          </ul>
        </div>
      )
    }
  }

  accountField = account_type => {
    return (
      <div className="form-group">
        <label htmlFor={`operation_${account_type}_account`}>
          {account_type[0].toUpperCase() + account_type.substring(1, account_type.length)} account
        </label>
        <select className="form-control" name={`operation[${account_type}_account_id]`} id={`operation_${account_type}_account`}>
          <option value="">Please select</option>
          {this.props.accounts.map((a) => <option key={a.id} value={a.id}>{a.name}</option>)}
        </select>
      </div>
    );
  }

  accountFields = operation_type => {
    switch(operation_type) {
      case 'income':
        return (
          this.accountField('debit')
        );
      case 'outlay':
        return (
          this.accountField('credit')
        );
      case 'transaction':
        return (
          <div>
            { this.accountField('debit') }
            { this.accountField('credit') }
          </div>
        );
    }
  }

  render() {
    return(
      <form id="new_operation" action="/operations" acceptCharset="UTF-8" method="post" onSubmit={(e) => this.setState({disabled: true})}>
        <input type="hidden" name="authenticity_token" value={this.props.authenticity_token}/>

        {this.errorsBlock()}

        <div className="mb-2 ta-center">
          <div className="form-check form-check-inline">
            <input
              className="form-check-input"
              type="radio"
              id="operation_income"
              name="operation[type_cd]"
              value="0"
              data-value="income"
              onChange={(e) => this.setState({ type: e.target.getAttribute("data-value") })} defaultChecked
            />
            <label htmlFor="operation_income">Income</label>
          </div>

          <div className="form-check form-check-inline">
            <input
              className="form-check-input"
              type="radio"
              id="operation_outlay"
              name="operation[type_cd]"
              value="1"
              data-value="outlay"
              onChange={(e) => this.setState({ type: e.target.getAttribute("data-value") })}
            />
            <label htmlFor="operation_outlay">Outlay</label>
          </div>

          <div className="form-check form-check-inline">
            <input
              className="form-check-input"
              type="radio"
              id="operation_transaction"
              name="operation[type_cd]" 
              value="2"
              data-value="transaction" 
              onChange={(e) => this.setState({ type: e.target.getAttribute("data-value") })}
            />
            <label htmlFor="operation_transaction">Transaction</label>
          </div>
        </div>

        {this.accountFields(this.state.type)}

        <div className="form-group">
          <label htmlFor="operation_sum">Sum</label>
          <input className="form-control" type="number" name="operation[sum]" id="operation_sum"/>
        </div>

        <div className="form-group">
          <label htmlFor="operation_fee">Fee</label>
          <input className="form-control" type="number" name="operation[fee]" id="operation_fee"/>
        </div>

        <div className="form-group">
          <label htmlFor="operation_note">Note</label>
          <input className="form-control" type="text" name="operation[note]" id="operation_note"/>
        </div>

        <div className="ta-center mt-4">
          <input
            type="submit"
            className="btn btn-primary"
            value={this.state.disabled ? 'Submitting...' : 'Submit'}
            disabled={this.state.disabled}
          />
        </div>
      </form>
    )
  }
}

export default NewOperationForm;
