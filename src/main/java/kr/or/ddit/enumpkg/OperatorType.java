package kr.or.ddit.enumpkg;

public enum OperatorType {
	PLUS('+', new RealOperator() {
		@Override
		public double realOperate(double left, double right) {
			return left+right;
		}
	}), 
	MINUS('-', new RealOperator() {
		@Override
		public double realOperate(double left, double right) {
			return left-right;
		}
	}),
	MULTIPLY('*', new RealOperator() {
		@Override
		public double realOperate(double left, double right) {
			return left*right;
		}
	}), 
	DIVIDE('/', new RealOperator() {
		@Override
		public double realOperate(double left, double right) {
			return left/right;
		}
	});
	
	OperatorType(char sign, RealOperator realOperator){
		this.sign = sign;
		this.realOperator = realOperator;
	}
	private char sign;
	public char getSign() {
		return sign;
	}
	private RealOperator realOperator;
	
	public double operate(double left, double right) {
		return realOperator.realOperate(left, right);
	}
}
