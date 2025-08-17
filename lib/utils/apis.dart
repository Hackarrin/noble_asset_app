class API {
  static const urlBase = "https://api.nobleassets.com.ng/";
  static const uRLASSETS = "https://assets.nobleassets.com.ng/";

  // assets
  static const uRLUSERPHOTO = "${uRLASSETS}users/";
  static const uRLINVESTMENTS = "${uRLASSETS}investment_types/";
  static const uRLIDPHOTO = "${uRLASSETS}identifications/";
  static const uRLSelfiePHOTO = "${uRLASSETS}selfie/";
  static const uRLAddressPHOTO = "${uRLASSETS}addresses/";
  static const uRLPromoPHOTO = "${uRLASSETS}promos/";

  // auth
  static const login = "${urlBase}auth/login";
  static const signup = "${urlBase}auth/signup";
  static const forgot = "${urlBase}auth/forgot";
  static const reset = "${urlBase}auth/reset";
  static const sendCode = "${urlBase}auth/send_verify_code";
  static const verifyCode = "${urlBase}auth/verify_code";

  // profile
  static const profile = "${urlBase}user/profile";
  static const setNOK = "${urlBase}user/next-of-kin";
  static const setVerification = "${urlBase}user/verification";
  static const setSelfie = "${urlBase}user/selfie";
  static const setProofOfAddress = "${urlBase}user/proof_of_address";
  static const setBVN = "${urlBase}user/bvn";
  static const setPassword = "${urlBase}user/password";
  static const setPhoto = "${urlBase}user/upload_photo";
  static const setCompany = "${urlBase}user/company";
  static const accountDelete = "${urlBase}user/delete";
  static const switchAccount = "${urlBase}user/switch_account";

  // savings
  static const getSavings = "${urlBase}savings";
  static const getSavingsLetter = "${urlBase}savings/get_letter";
  static const saveSavings = "${urlBase}savings/save";
  static const topupSavings = "${urlBase}savings/topup";
  static const cancelSavings = "${urlBase}savings/cancel";
  static const savingDetails = "${urlBase}savings/single";

  // investments
  static const saveInvestments = "${urlBase}investments/save";
  static const getInvestmentsTypes = "${urlBase}investments/types";
  static const getInvestmentsCategories = "${urlBase}investments/categories";
  static const getInvestments = "${urlBase}investments";
  static const getInvestmentsLetter = "${urlBase}investments/get_letter";
  static const investmentDetails = "${urlBase}investments/single";
  static const cancelInvestments = "${urlBase}investments/cancel";

  //referrer
  static const getReferrers = "${urlBase}refer";
  static const investorProfile = "${urlBase}user/investor-profile";

  //wallet
  static const getWallet = "${urlBase}wallet";
  static const getBanks = "${urlBase}wallet/banks";
  static const billPayments = "${urlBase}bills/banks";
  static const getBillNetworks = "${urlBase}bill/categories";
  static const getBillBeneficiaries = "${urlBase}bill/beneficiaries";
  static const payBill = "${urlBase}bill/pay";
  static const verifyBill = "${urlBase}bill/validate";
  static const topupWallet = "${urlBase}wallet/topup";
  static const withdrawWallet = "${urlBase}wallet/withdraw";
  static const getTransactions = "${urlBase}wallet/transactions";
  static const getAllTransactions = "${urlBase}wallet/allTransactions";
  static const saveAccount = "${urlBase}wallet/account_update";
  static const getInterest = "${urlBase}wallet/get_interest";
  static const getPortfolio = "${urlBase}wallet/portfolio_download";
  static const getStatement = "${urlBase}wallet/account_statement_download";

  // misc
  static const getDefaults = "${urlBase}misc/defaults";
  static const charge = "${urlBase}misc/charge";
  static const fetchKey = "${urlBase}misc/key";
  static const verifyAccount = "${urlBase}misc/verify_account";
  static const verifyBank = "${urlBase}misc/verify_bank";
  static const getWithdrawalBanks = "${urlBase}misc/withdrawal_banks";
  static const getSavingsPlans = "${urlBase}misc/savings_plans";
  static const saveDevice = "${urlBase}misc/save_device";
  static const logoutDevice = "${urlBase}misc/logout_device";

  // stocks
  static const stockMarket = "${urlBase}stock";
  static const stockDetail = "${urlBase}stock/single";
  static const stockBuy = "${urlBase}stock/buy";
  static const stockAccount = "${urlBase}stock/create_account";
  static const stockSell = "${urlBase}stock/sell";
  static const stockCancel = "${urlBase}stock/cancel";
  static const stockPortfolio = "${urlBase}stock/portfolio";
  static const stockTradeList = "${urlBase}stock/trade_list";

  static String path(String root, String sublink) {
    return "$root$sublink";
  }
}
