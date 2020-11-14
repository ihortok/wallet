let operation_type = document.getElementById('operation_type_cd');
let debit_account = document.getElementsByClassName('debit_account')[0];
let credit_account = document.getElementsByClassName('credit_account')[0];
let transaction_fee = document.getElementsByClassName('transaction_fee')[0];

operation_type_fields();

operation_type.addEventListener('change', function() {
  operation_type_fields();
});

function operation_type_fields() {
  let type_cd = operation_type.value;

  switch(type_cd) {
    case '0': {
      income();
      break;
    }
    case '1': {
      outlay();
      break;
    }
    case '2': {
      transaction();
      break;
    }
  }
}

function income() {
  if (!credit_account.classList.contains('d-none')) {
    credit_account.classList.add('d-none');
  }
  if (!transaction_fee.classList.contains('d-none')) {
    transaction_fee.classList.add('d-none');
  }

  debit_account.classList.remove('d-none');
}

function outlay() {
  if (!debit_account.classList.contains('d-none')) {
    debit_account.classList.add('d-none');
  }
  if (!transaction_fee.classList.contains('d-none')) {
    transaction_fee.classList.add('d-none');
  }

  credit_account.classList.remove('d-none');
}

function transaction() {
  debit_account.classList.remove('d-none');
  credit_account.classList.remove('d-none');
  transaction_fee.classList.remove('d-none');
}
