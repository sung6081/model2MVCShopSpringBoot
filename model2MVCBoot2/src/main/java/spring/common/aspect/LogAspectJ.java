package spring.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

/*
 * FileName : PojoAspectJ.java
 *	:: XML �� ���������� aspect �� ����   
  */
@Aspect
@Component
public class LogAspectJ {

	///Constructor
	public LogAspectJ() {
		System.out.println("\nCommon :: "+this.getClass()+"\n");
	}
	
	@Around("execution(* spring..*Impl.*(..))")
	//Around  Advice
	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable {
			
		System.out.println("");
		System.out.println("[Around before] Ÿ����ü.�޼��� :"+
													joinPoint.getTarget().getClass().getName() +"."+
													joinPoint.getSignature().getName());
		if(joinPoint.getArgs().length !=0){
			System.out.println("[Around before]method�� ���޵Ǵ� ���� : "+ joinPoint.getArgs()[0]);
		}
		//==> Ÿ�� ��ü�� Method �� ȣ�� �ϴ� �κ� 
		Object obj = joinPoint.proceed();

		System.out.println("[Around after] Ÿ�� ��üreturn value  : "+obj);
		System.out.println("");
		
		return obj;
	}
	
}//end of class