package kr.or.ddit.vo;

import java.io.Serializable;

public class ItzyVO implements Serializable{
	
	
	public ItzyVO() {
		super();
	}
	
	public ItzyVO(String name, String page) {
		super();
		this.name = name;
		this.page = page;
	}
	
	private String name;
	private transient String page;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((page == null) ? 0 : page.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ItzyVO other = (ItzyVO) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (page == null) {
			if (other.page != null)
				return false;
		} else if (!page.equals(other.page))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "ItzyVO [name=" + name + ", page=" + page + "]";
	}
	
}
